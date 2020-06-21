require File.dirname(__FILE__) + '/test_helper.rb'

assert('add event') do
  app = Mrbmacs::TestApp.new
  $test_data = 0
  app.add_sci_event(Scintilla::SCN_CHARADDED) do |app, scn|
    $test_data = 1
  end
  assert_equal(100, app.sci_handler[Scintilla::SCN_CHARADDED].first.priority)
  app.call_sci_event({'code' => Scintilla::SCN_CHARADDED})
  assert_equal(1, $test_data)

  app.add_sci_event(Scintilla::SCN_CHARADDED) do |app, scn|
    $test_data = 2
  end
  assert_equal(101, app.sci_handler[Scintilla::SCN_CHARADDED].last.priority)
  app.call_sci_event({'code' => Scintilla::SCN_CHARADDED})
  assert_equal(2, $test_data)
end

assert('add event with priority') do
  app = Mrbmacs::TestApp.new
  $test_data = 0
  app.add_sci_event(Scintilla::SCN_CHARADDED, 10) do |app, scn|
    $test_data = 1
  end
  assert_equal(10, app.sci_handler[Scintilla::SCN_CHARADDED].first.priority)
  app.call_sci_event({'code' => Scintilla::SCN_CHARADDED})
  assert_equal(1, $test_data)

  app.add_sci_event(Scintilla::SCN_CHARADDED, 1) do |app, scn|
    $test_data = 2
  end
  assert_equal(1, app.sci_handler[Scintilla::SCN_CHARADDED].first.priority)
  app.call_sci_event({'code' => Scintilla::SCN_CHARADDED})
  assert_equal(1, $test_data)
end
