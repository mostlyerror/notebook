import unittest
from selenium import webdriver
from selenium.webdriver.common.keys import Keys
from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions

class PacStagingLogin(unittest.TestCase):
    def setUp(self):
        chrome_options = webdriver.ChromeOptions()
        chrome_options.add_argument('--headless')
        chrome_options.add_argument('--no-sandbox')
        chrome_options.add_argument('--window-size=1420,1080')
        chrome_options.add_argument('--disable-gpu')
        self.driver = webdriver.Chrome(options=chrome_options)

    def test_login(self):
        driver = self.driver
        driver.get('https://pac.staging.therightplace.com')
        assert "SIGN IN" in driver.page_source
        email_input_field = driver.find_element_by_xpath('//*[@id="app"]/div/div/form/div[1]/div[1]/input')
        password_input_field = driver.find_element_by_xpath('//*[@id="app"]/div/div/form/div[1]/div[2]/input')
        email_input_field.send_keys('ben@therightplace.com')
        password_input_field.send_keys('Vision123!')
        password_input_field.send_keys(Keys.RETURN)
        try:
            el = WebDriverWait(driver, 4).until(
                expected_conditions.presence_of_element_located((By.XPATH, '//*[@id="page"]/div[1]/div[1]/div[1]/a'))
                )
        finally:
            # driver.quit()
        assert "Avondale" in driver.page_source

    def tearDown(self):
        self.driver.close()


if __name__ == "__main__":
    unittest.main()


