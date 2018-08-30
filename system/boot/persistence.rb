Container.boot(:persistence) do |container|
  init do
    require 'riak'
  end

  start do
    use :logger

    db = Riak::Client.new

    register(:db, db)
  end
end
