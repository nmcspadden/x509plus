#certificate provider

# 1: Does the certificate already exist? If it does, we're good
# 1a: Verify certificate matches private key
# 2: Does a CSR already exist?  
# 2a: Do we have the private key to the CSR?
# 2b: If it exists and we have key, check to make sure it's in data bag
# 3: We need to generate a CSR
# 3b: Do we have a private key? If yes, skip 3c.
# 3c: Generate private key
# 3d: Does csr_attributes exist? If yes, add extensions.
# 3e: Create CSR, save in path provided by resource declaration