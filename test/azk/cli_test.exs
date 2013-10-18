defmodule Azk.Cli.Test do
  use Azk.TestCase

  test "show version" do
    version = "Azk #{Mix.project[:version]}\n"
    assert version == capture_io(fn ->
      Azk.Cli.run ["--version"]
    end)
    assert version == capture_io(fn ->
      Azk.Cli.run ["-v"]
    end)
  end

  test "show a error if azkfile is required but not exist" do
    File.cd! fixture_path(:no_azkfile), fn ->
      expection = Azk.Cli.NoAzkfileError.new(app_folder: System.cwd!)
      assert capture_io(fn ->
        try do
          Azk.Cli.run(["exec"])
        catch
          :exit, code -> IO.write("#{code}")
        end
      end) == "** (Azk) #{expection.message}\n1"
    end
  end
end
