class Hiera
  module Backend
    class Args_backend
      def initialize
        Hiera.debug('Hiera args backend starting')
      end

      def lookup(key, scope, order_override, resolution_type, context)
        Hiera.debug(
            "Looking up #{key} in args backend with #{resolution_type}")

        Backend.parse_answer(
            scope[:args][key] || throw(:no_such_key),
            scope)
      end
    end
  end
end