require 'digest/sha1'

# Generate a random token given a secret, enrollment number and poll filename.
def token(secret, enrollment, filename)
  Digest::SHA1.hexdigest( Digest::SHA1.hexdigest(secret) + Digest::SHA1.hexdigest( Digest::SHA1.hexdigest(enrollment) + Digest::SHA1.hexdigest(filename) ) )
end

# Given the secret and filename, find the enrollment number in the array
# search_space for which the given token is correct. Returns nil on failure.
def find_enrollment(access_token, secret, filename, search_space)
  search_space.select {|x| token(secret, x, filename) == access_token }[0]
end
