Container.boot(:config) do |container|
  container.namespace(:config) do
    register(:riak_node_url) { ENV.fetch('RIAK_NODE_URL') }
  end
end
