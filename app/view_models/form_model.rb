class FormModel
  include ActiveModel::Model

  attr_accessor :name, :time_limit, :download_limit, :upload_limit, :slug, :cleartext_password

  validates :name, :time_limit, :download_limit, :upload_limit, presence: true

  def self.all
    rad_check_groups = RadCheckGroup.all
    form_models = {}
    rad_check_groups.map do |group|
      form_models[group.groupname] = FormModel.new unless form_models.key?(group.groupname)
      form_models[group.groupname].send("#{group.attr.to_s.downcase.gsub('-', '_')}=" , group.value)
      form_models[group.groupname].name = group.groupname
      form_models[group.groupname].slug = group.groupname.parameterize
    end
    form_models.map { |_key, value| value}.flatten
  end

  def self.find(slug)
    time     = RadCheckGroup.where(groupname: slug.humanize, attr: :time_limit).first
    download = RadCheckGroup.where(groupname: slug.humanize, attr: :download_limit).first
    upload   = RadCheckGroup.where(groupname: slug.humanize, attr: :upload_limit).first
    cleartext_password   = RadCheckGroup.where(groupname: slug.humanize, attr: :'Cleartext-Password').first

    FormModel.new(name: slug.humanize, time_limit: time.value, download_limit: download.value, upload_limit: upload.value, slug: slug, cleartext_password: cleartext_password.value)
  end

  def save
    time     = RadCheckGroup.where(groupname: slug.humanize, attr: :time_limit).first || RadCheckGroup.new(groupname: slug.humanize, op: ':=', attr: :time_limit)
    download = RadCheckGroup.where(groupname: slug.humanize, attr: :download_limit).first || RadCheckGroup.new(groupname: slug.humanize, op: ':=', attr: :download_limit)
    upload   = RadCheckGroup.where(groupname: slug.humanize, attr: :upload_limit).first || RadCheckGroup.new(groupname: slug.humanize, op: ':=', attr: :upload_limit)
    cleartext_password   = RadCheckGroup.where(groupname: slug.humanize, attr: :'Cleartext-Password').first || RadCheckGroup.new(groupname: slug.humanize, op: ':=', attr: :'Cleartext-Password')

    time.value = self.time_limit
    download.value = self.download_limit
    upload.value = self.upload_limit
    cleartext_password.value = self.cleartext_password
    

    time.save!
    download.save!
    upload.save!
    cleartext_password.save!
  end
end