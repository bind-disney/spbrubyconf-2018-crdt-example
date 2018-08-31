Container.boot(:persistence) do |container|
  init do
    require 'riak'
  end

  start do
    use :logger

    db = Riak::Client.new(
      nodes: [
        {
          host: ENV.fetch('RIAK_NODE_HOST'),
          pb_port: ENV.fetch('RIAK_NODE_PORT')
        }
      ]
    )

    container.register(:db, db)

    register_code(Hanami.root)
  end

  def register_code(root)
    Hanami::Utils.require!(root.join('lib/entities'))
    Hanami::Utils.require!(root.join('lib/repositories'))

    # NOTE: For example, register lib/user_repository.rb as repositories.user
    container.namespace('repositories') do
      root.glob('lib/repositories/*.rb').each do |file|
        name = file.basename('.rb').to_s
        key = name.sub('_repository', '')
        const_name = Inflecto.camelize(name)
        const = Object.const_get(const_name)

        register(key, memoize: true) { const.new }
      end
    end
  end
end
