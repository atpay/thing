module Thing
  class BenGrimm
    def initialize
      @runs = {}
      @runners = {}

      puts "\nIt's Clobberin' Time...\n\n"
    end

    # TODO: We should handle existing IDs so new workers can come up mid run.
    def start_run(id, suite)
      @runs[id] = [Suite.new(suite), Tab.new(id)]

      :ok
    end

    def launch_test(location)
      @runners[location[0]] = {}
      @runners[location[0]][location[1]] = Time.now

      test_to_run(location[0])
    end

    def end_test(location, results)
      @runs[location[0]][1].add_item format_results(location, results)

      :ok
    end

    def end_run(id)
      @runs[id][1].close_out

      @runs.delete id
      @runners.delete id

      :ok
    end


    private

    def format_results(points, results)
      start = @runners[points[0]][points[1]]
      now = Time.now

      [
        start,
        now,
        now - start,
        results[:outcome],
        results[:test]
      ]
    end

    def test_to_run(test_run)
      @runs[test_run][0].next_test
    end
  end
end