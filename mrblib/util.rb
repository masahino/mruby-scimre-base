# util
module Mrbmacs
  def self.homedir
    if !ENV['HOME'].nil?
      ENV['HOME']
    elsif !ENV['HOMEDRIVE'].nil?
      ENV['HOMEDRIVE'] + ENV['HOMEPATH']
    else
      ''
    end
  end
end
