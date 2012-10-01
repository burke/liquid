module Liquid

  # Thunk is a special value, used to partially apply templates, enabling
  # two-phase HTML generation.
  class Thunk
    def self.[](*)
      self
    end
    def self.to_liquid
      self
    end
  end

  class Thunked < StandardError
  end

end
