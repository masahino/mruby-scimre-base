# util
module Mrbmacs
  def self.common_prefix(strings)
    return nil if strings.empty? || strings.include?('')

    min_length = strings.min_by(&:length).length

    (1..min_length).reverse_each do |prefix_length|
      prefix = strings.first[0, prefix_length]
      return prefix if strings.all? { |str| str.start_with?(prefix) }
    end
    nil
  end

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
