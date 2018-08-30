module Operation
  include Dry::Monads::Result::Mixin
  include Dry::Monads::Do.for(:call)
end
