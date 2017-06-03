require "acts_as_encryptable/version"

module ActsAsEncryptable
  def acts_as_encryptable column_name, key, salt
    send :define_method, column_name do
      encryptor = "@encryptor_#{key}_#{salt}"

      instance_variable_set(
        encryptor,
        ActiveSupport::MessageEncryptor.new(
          ActiveSupport::KeyGenerator.new(send key).generate_key(send(salt), 32)
        )
      ) unless instance_variable_defined? encryptor

      encryptor = instance_variable_get(encryptor)
      encryptor.decrypt_and_verify(read_attribute column_name)
    end

    send :define_method, "#{column_name}=".to_sym do |value|
      encryptor = "@encryptor_#{key}_#{salt}"

      instance_variable_set(
        encryptor,
        ActiveSupport::MessageEncryptor.new(
          ActiveSupport::KeyGenerator.new(send key).generate_key(send(salt), 32)
        )
      ) unless instance_variable_defined? encryptor

      encryptor = instance_variable_get(encryptor)
      write_attribute column_name, encryptor.encrypt_and_sign(value)
    end
  end
end
