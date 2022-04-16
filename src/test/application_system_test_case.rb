require "test_helper"

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  driven_by :selenium, using: :chrome, screen_size: [1400, 1400], options: {
    browser: :remote,
    url: ENV.fetch("SELENIUM_DRIVER_URL"),
  }

  Capybara.server_host = IPSocket.getaddress(Socket.gethostname)
end
