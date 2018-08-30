require 'dry/system/container'
require 'dry/monads/do'
require 'dry/monads/do/all'
require 'representable/decorator'
require 'representable/json'

class Container < Dry::System::Container
  extend Dry::System::Hanami::Resolver

  class Registry < Dry::Container::Registry
    def call(container, key, item, options)
      options = { memoize: true }.merge(options) if item.is_a?(Proc)
      super
    end
  end

  configure do |config|
    config.registry = Registry.new
  end

  load_paths! 'lib'

  register_folder! 'entities'
  register_folder! 'helpers'
  register_folder! 'operations'
  register_folder! 'queries'
  register_folder! 'repositories'
end

require_relative 'import'

Hanami::Utils.for_each_file_in(Hanami.root.join('lib')) do |file|
  next if file.include?('lib/entities')
  next if file.include?('lib/repositories')

  require file
end
