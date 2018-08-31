require 'bundler/setup'
require 'hanami/setup'
require_relative '../lib/imperial_instagram'
require_relative '../apps/web/application'
require_relative '../system/container'

# NOTE: Use dry-system for lib directory management
Hanami::Components.register('code') do
  run {}
end

Hanami.configure do
  mount Web::Application, at: '/'

  environment :development do
    # See: http://hanamirb.org/guides/projects/logging
    logger level: :debug
  end

  environment :production do
    logger level: :info, formatter: :json, filter: []
  end
end
