Fever on Heroku Bootstrap
=========================
A bootstrap script to start Fever on Heroku


Why
=========================
As you all may know, Google announced that their RSS agregator service, Google Reader going to shut down.
To me this is really sad news becuase I relied on Google Reader and Reeder for iOS. Just after hearing the news I've been looking for good substitute, then finally I found Fever (http://feedafever.com/)

Although Fever has a nice feature that it automatically picks up hot news, it requires your own server.
Even though many people can have their own server today, it's a little more difficult than just using other hosting services.

However Justin Morris wrote up whole instruction to set up Fever on Heroku platform so that you don't have to have your own servers.

Based on his instruction, I wrote a tiny script to boot up your own Fever service on Heroku.


Requirement
=========================
* Paypal account (http://paypal.com)
* Fever account (http://feedafever.com)
* Heroku account (http://heroku.com)


How
=========================
#### Step 1: Run bootstrap script.

    curl -O https://raw.github.com/maloninc/fever-on-heroku-bootstrap/master/bootstrap.sh; sh bootstrap.sh

or

Download and run this simple script.


#### Step 2: After running the script, you will see your browser opening your own Fever site as the following

![001](https://raw.github.com/maloninc/fever-on-heroku-bootstrap/master/images/001.png)


#### Step 3: Click "proceed regardless".


#### Step 4: Enter MySQL database credential.

![002](https://raw.github.com/maloninc/fever-on-heroku-bootstrap/master/images/002.png)

You will see the following information just right after running the script.

    Here is MySQL database credential
    Array
    (
        [scheme] => mysql
        [host] => us-cdbr-example-00.cleardb.com
        [user] => aabbccddeeff
        [pass] => ppaasswwoorrdd
        [path] => /heroku_aaabbbcccddd
        [query] => reconnect=true_
    )

NOTE: "path" is the database name, just leave out the / at the start

#### Step 5: Purchase Fever license and enter an activation key from Fever site.

![003](https://raw.github.com/maloninc/fever-on-heroku-bootstrap/master/images/003.png)


#### Step 6: Create login.

Enter your e-mail address and password to login to your own RSS server. You can chose your favorite temperature scale from Celsius and Fahrenheit.

![004](https://raw.github.com/maloninc/fever-on-heroku-bootstrap/master/images/004.png)


#### Step 7: Click "choose opml" to import your OPML if you need.

![005](https://raw.github.com/maloninc/fever-on-heroku-bootstrap/master/images/005.png)


#### Step 8: To set up automatic refresh, run the following command. It will open Heroku Scheduler website.

    heroku addons:open scheduler


#### Step 9: Then enter the following command to the command field.

![006](https://raw.github.com/maloninc/fever-on-heroku-bootstrap/master/images/006.png)

    curl -L -s http://YOUR_HEROKU_APP/fever/?refresh


#### Step 10: Now you have your own RSS server.


Special Thanks
=========================
Thanks to Justin Morris for writing up a gist this bootstrap is based on.

https://gist.github.com/plasticine/5175588


Verified Platforms
=========================
* Mac OS X 10.8