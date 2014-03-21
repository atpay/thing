module Thing
  class Suite
    def initialize(suite)
      @state = map_suite load(suite)
    end

    def next_test
      @state.delete_if { |test| test[1] == 0 }

      if @state.first
        @state.first[1] -= 1
        @state.first[0]
      else
        nil
      end
    end

    # allow random and sequential

    private

    def load(suite)
      YAML.load_file "#{suite_dir}/#{suite}.yml"
    end

    def map_suite(suite)
      suite.inject([]) do |list, pair|
        list << pair
      end
    end

    def suite_dir
      File.expand_path '../../suites', File.dirname(__FILE__)
    end
  end
end