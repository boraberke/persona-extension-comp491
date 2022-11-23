from selenium import webdriver
from selenium.webdriver.common.keys import Keys
from selenium.webdriver.common.by import By
from selenium.webdriver.chrome.options import Options
import threading

#todo yüklenmeden yeni tab aç track this link gibi

driver_path = "chromedriver"

def brows_bot():
    cookies = []
    webBrowser = webdriver.Chrome(driver_path)
    webBrowser.get("http://www.python.org")
    cookies1  = webBrowser.get_cookies();  
    cookies.append(cookies1)
    

    # Lets open https://www.bing.com/ in the second tab
    webBrowser.execute_script("window.open('about:blank', 'secondtab');")
    webBrowser.switch_to.window("secondtab")
    webBrowser.get('https://www.bing.com/')
    webBrowser.get_cookies();  
    cookies2  = webBrowser.get_cookies();  
    cookies.append(cookies2)

    # Lets open https://www.facebook.com/ in the third tab
    webBrowser.execute_script("window.open('about:blank', 'thirdtab');")
    webBrowser.switch_to.window("thirdtab")
    webBrowser.get('https://www.facebook.com/')
    webBrowser.get_cookies();  
    cookies3  = webBrowser.get_cookies();  
    cookies.append(cookies3)

    webBrowser.switch_to.window("secondtab")
    webBrowser.get('https://www.geeksforgeeks.org/')
    webBrowser.get_cookies();  
    cookies4  = webBrowser.get_cookies();  
    cookies.append(cookies4)
    

def brows_bot2():
    webBrowser = webdriver.Chrome(driver_path)
    cookies = []
    webBrowser.get("https://reactjs.org/")
    webBrowser.get_cookies();  
    cookies1  = webBrowser.get_cookies();  
    cookies.append(cookies1)

    # Lets open https://www.bing.com/ in the second tab
    webBrowser.execute_script("window.open('about:blank', 'secondtab');")
    webBrowser.switch_to.window("secondtab")
    webBrowser.get('https://coens.io/')
    webBrowser.get_cookies();  
    cookies2  = webBrowser.get_cookies();  
    cookies.append(cookies2)

    # Lets open https://www.facebook.com/ in the third tab
    webBrowser.execute_script("window.open('about:blank', 'thirdtab');")
    webBrowser.switch_to.window("thirdtab")
    webBrowser.get('https://www.koctas.com.tr')
    webBrowser.get_cookies();  
    cookies3  = webBrowser.get_cookies();  
    cookies.append(cookies3)


    webBrowser.switch_to.window("secondtab")
    webBrowser.get('https://www.boyner.com.tr')
    webBrowser.get_cookies();  
    cookies4  = webBrowser.get_cookies();  
    cookies.append(cookies4)

def double_thread_multi_tab_v1():
    print("Starting Double Thread Multi Tab")
    t1 = threading.Thread(target=brows_bot)
    t2 = threading.Thread(target=brows_bot2)
    # starting thread 1
    t1.start()
    # starting thread 2
    t2.start()

    # wait until thread 1 is completely executed
    t1.join()
    # wait until thread 2 is completely executed
    t2.join()





double_thread_multi_tab_v1()