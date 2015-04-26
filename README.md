##Configuration  
Create an .env file that contains 
STEAM_API_KEY=\<key\>  
GIANTBOMB_API_KEY=\<key\>  
SECRET_KEY_BASE=\<key\>  
SECRET_TOKEN=\<key\>  
  
For development:  
Run: export $(cat .env)  
  
For testing:  
foreman run rails s  