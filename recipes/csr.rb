require 'openssl'

## THIS PART CREATES A CSR

#Create keys
keypair = OpenSSL::PKey::RSA.new 2048

#Create CSR
name = OpenSSL::X509::Name.parse("CN=chef/DC=sacredsf/DC=org")
csr = OpenSSL::X509::Request.new
csr.version = 0
csr.subject = name
csr.public_key = keypair.public_key
csr.sign keypair, OpenSSL::Digest::SHA256.new

#Add extension requests
extensions = []
#Serial number
oid = '1.3.6.1.4.1.34380.1.2.1.1'
value = 'C02MM008FPF3'
ext = OpenSSL::X509::Extension.new(oid, value.to_s, false)
extensions << ext
#Virtual / not virtual
oid = '1.3.6.1.4.1.34380.1.2.1.2'
value = 'physical'
seq = OpenSSL::ASN1::Sequence(extensions)
ext_req = OpenSSL::ASN1::Set([seq])
csr.add_attribute(OpenSSL::X509::Attribute.new("extReq", ext_req))

open 'csr.csr', 'w' do |io| io.write csr.to_pem end