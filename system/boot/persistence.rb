Container.boot(:persistence) do |container|
  init do

  end

  start do
    use :logger

    # TODO: establish real connection to Riak
    db = {}

    register(:db, db)
  end
end
