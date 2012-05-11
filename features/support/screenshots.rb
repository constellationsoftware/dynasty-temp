After('@javascript') do |scenario|
    if (scenario.failed?)
        page.driver.browser.save_screenshot("tmp/html-report/#{scenario.__id__}.png")
        embed("#{scenario.__id__}.png", "image/png", "SCREENSHOT")
    end
end
