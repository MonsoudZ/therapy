module Cacheable
  extend ActiveSupport::Concern

  class_methods do
    def cache_key_for(record, *args)
      "#{record.class.name.downcase}_#{record.id}_#{args.join('_')}"
    end

    def cache_with_version(key, version = nil)
      version ? "#{key}_v#{version}" : key
    end
  end

  def cache_key_for(*args)
    self.class.cache_key_for(self, *args)
  end

  def cache_with_version(key, version = nil)
    self.class.cache_with_version(key, version)
  end
end
