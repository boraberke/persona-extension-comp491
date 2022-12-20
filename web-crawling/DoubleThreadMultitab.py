from selenium import webdriver
#from selenium.webdriver.chrome.options import Options
import threading

#todo yüklenmeden yeni tab aç track this link gibi
#links = ['https://www.bing.com/','https://www.facebook.com/','https://www.geeksforgeeks.org/','https://coens.io/', "https://reactjs.org/", 'https://www.boyner.com.tr']

def doubleThreadMultitab(links, driver_path = "/Users/emresafter/persona-extension-comp491/web-crawling/chromedriver"):
    middle_index = len(links) // 2
    first_half=links[:middle_index]
    sec_half=links[middle_index:]

    def brows_bot(links):
        cookies = []
        webBrowser = webdriver.Chrome(driver_path)

        first_link = links[0]
        rest_links = links[1:]
        webBrowser.get(first_link)
        cookie = webBrowser.get_cookies()
        cookies.append(cookie)

        for i,link in enumerate(rest_links):
            
            webBrowser.execute_script("window.open('about:blank', '{index}tab');".format(index = i))
            print("window.open('about:blank', '{index}tab');".format(index = i))
            webBrowser.switch_to.window("{index}tab".format(index = i))
            webBrowser.get(link)
            cookie = webBrowser.get_cookies()
            cookies.append(cookie)

        return cookies

    
    print("Starting Double Thread Multi Tab")
    t1 = threading.Thread(target=brows_bot, args=(first_half,))
    t2 = threading.Thread(target=brows_bot, args=(sec_half,))
    # starting thread 1
    t1.start()
    # starting thread 2
    t2.start()

    # wait until thread 1 is completely executed
    t1.join()
    # wait until thread 2 is completely executed
    t2.join()





    #double_thread_multi_tab_v1()

