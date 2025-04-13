#Импорт модулей
from pygame import *
from random import randint
font.init()
#Создание текста
font1 = font.SysFont('Arial', 75)
font4 = font.SysFont('Arial', 150)
lost = font4.render(
    'YOU LOSE', True, (255, 0, 0)

)
#Переменные
global score
lose = 0

#Cоздание классов  

class GameSprite(sprite.Sprite):
    def __init__(self, player_height , player_wight , player_image , player_x , player_y , player_speed):
        super().__init__()
        self.height = player_height
        self.wight = player_wight
        self.image = transform.scale(image.load(player_image),(player_height , player_wight))
        self.speed = player_speed
        self.rect = self.image.get_rect()
        self.rect.x = player_x
        self.rect.y = player_y
    def reset(self):
        window.blit(self.image,(self.rect.x,self.rect.y))



class Player(GameSprite):
    def update(self):
        keys = key.get_pressed()
        if keys[K_d] and self.rect.x < 750:
            self.rect.x += self.speed
        if keys[K_a] and self.rect.x > 50:
            self.rect.x -= self.speed


class Enemy(GameSprite):
    
    def update(self):
        self.rect.y += self.speed
        if self.rect.y > 700:
            self.rect.x = randint(5,700)
            self.rect.y = 5
            global lose
            lose += 1

class Button(GameSprite):

    def click(self):
        keys = key.get_pressed()
        if keys[K_1] :
            self.enemy_speed = randint(1,3)
        if keys[K_2] :          
            self.enemy_speed = randint(4,6)        
        if keys[K_3] :    
            self.enemy_speed = randint(7,9)
        if keys[K_4] :        
            self.enemy_speed = randint(10,12)            


#Прорисовка обьектов
mixer.init()
mixer.music.load('zvuki-goroda-shosse.ogg')
mixer.music.play()

window = display.set_mode((900,700))
display.set_caption('Гонки')
background = transform.scale(image.load("doroga.png"), (900,700))
clock = time.Clock()
FPS = 60
x1 = 450
y1 = 550
#Основный обьекты
player = Player(80 , 125 ,"car_1047003.png" , x1 , y1 , 9)
but1 = Button(50 , 50 ,"button.png" , 60 , 100 , 0)
but2 = Button(50 , 50 ,"button.png" , 150 , 100 , 0)
but3 = Button(50 , 50 ,"button.png" , 250 , 100 , 0)
but4 = Button(50 , 50 ,"button.png" , 350 , 100 , 0)
cars = sprite.Group()
global enemy_speed
enemy_speed = 5



for i in range(4):
    koord = randint(1,4)
    x_car = 0
    if koord == 1:
        x_car =  260
    elif koord == 2:
        x_car = 560    
    elif koord == 3:
        x_car = 760
    else:
        x_car = 775
    car = Enemy(90 , 125 , "car_1655213.png" ,  x_car  , -200 , enemy_speed )
    cars.add(car)


#Прорисовка окна
finish = False
game = True
while game:

    window.blit(background,(0, 0))

    background = transform.scale(image.load("doroga.png"), (900,700))
    clock.tick(FPS)
    for e in event.get():
        if e.type == QUIT:
            game = False
      
      

    #Игра
    if finish != True:
        window.blit(background,(0, 0))

        text = font1.render('Счет:'+str(lose),1,(0, 255, 255))
        window.blit(text,(10, 10))
        #Победа
        #Поражение
        sprites_list = sprite.spritecollide(
            player , cars, False
        )          
        if sprite.spritecollide(player , cars, False):
            window.blit(lost,(150, 250))        
            finish = True        
    
        player.update()
        cars.draw(window)
        cars.update()
        player.reset()

        but1.update()
        but1.reset()   
        but2.update()
        but2.reset()       
        but3.update()
        but3.reset()   
        but4.update()
        but4.reset()            

        display.update()    
    
