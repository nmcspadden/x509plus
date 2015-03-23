require 'openssl'

## THIS PART CREATES A CERTIFICATE

#Create keys
keypair = OpenSSL::PKey::RSA.new 2048

#Save keys to disk
open 'private_key.pem', 'w' do |io| io.write keypair.to_pem end
open 'public_key.pem', 'w' do |io| io.write keypair.to_pem end

#Create cert
name = OpenSSL::X509::Name.parse("CN=chef/DC=sacredsf/DC=org")
cert = OpenSSL::X509::Certificate.new()
cert.version = 2
cert.serial = 0
cert.not_before = Time.new()
cert.not_after = cert.not_before + (60*60*24*365)
cert.public_key = keypair.public_key
cert.subject = name

#Sign cert
cert.issuer = name
cert.sign keypair, OpenSSL::Digest::SHA256.new()

#Save cert to disk
open("certificate.pem", "w") do |io| io.write(cert.to_pem) end