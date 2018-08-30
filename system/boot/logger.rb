Container.boot(:logger) do |container|
  container.register(:logger, Hanami.logger)
end
