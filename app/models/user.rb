class User < Struct.new(:name, :role)

  def self.authenticate(user_name, password)
    bases = ENV['LDAP_BASE'].split('|')
    is_authentication_successful = false
    ldap = nil
    bases.each do |base|
      ldap = configure_ldap(base)
      ldap.auth("#{user_name}@rpxcorp.com", password)
      is_authentication_successful = true and break if ldap.bind
    end
    return false unless is_authentication_successful
    attributes = ENV['LDAP_ATTRIBUTES'].split(',')
    filter = Net::LDAP::Filter.eq(attributes.first, "#{user_name}@rpxcorp.com")
    bases.each do |base|
      results = ldap.search(:base => base, filter: filter, attributes: attributes, scope: Net::LDAP::SearchScope_SingleLevel)
      next if results.blank?
      result = results.first
      role = "user" if result.present? && result.memberof.include?(ENV['LDAP_USER_GROUP'])
      role = "admin" if result.present? && result.memberof.include?(ENV['LDAP_ADMIN_GROUP'])
      return User.new(result.name.first, role) if result.present? && role
    end
    return User.new('Document OCR Service', 'admin') if user_name.eql?('document_ocr_service')
    nil
  end

  def self.configure_ldap(base)
    Net::LDAP.new(host: ENV['LDAP_HOST'], port: ENV['LDAP_PORT'], base: base,
                  encryption: {method: :simple_tls, tls_options: {verify_mode: OpenSSL::SSL::VERIFY_NONE}})
  end

  def admin?
    role == "admin"
  end
end
