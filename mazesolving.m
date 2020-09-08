%brick = ConnectBrick('BRICKED');
angle = 220;
dist = 21;
distance = brick.UltrasonicDist(2);
display(distance);
blue = 2;
green = 3;
yellow = 4;
red = 5;

while 1
    %brick.StopAllMotors('Brake');
    brick.SetColorMode(1, 2);
    color = brick.ColorCode(1);
    %display(color);
    if color == red                    
        brick.StopAllMotors('Brake');
        display("stopped");
        pause(2);
        brick.MoveMotor('AB',30);
        pause(0.5);
    end
    if color == yellow
        brick.MoveMotor('AB',20);
        pause(0.5);
        brick.SetColorMode(1, 2);
        color = brick.ColorCode(1);
        if color == yellow
            display("Color = "+color);
            break;
        end
        
    end
    if color == blue
        brick.MoveMotor('AB',20);
        pause(0.5);
        brick.SetColorMode(1, 2);
        color = brick.ColorCode(1);
        if color == blue
            display("Color = "+color);
            break;
        end
        
    end
    distance = brick.UltrasonicDist(2);
    touch = brick.TouchPressed(3);
    touch2 = brick.TouchPressed(4);
    if touch || touch2
        brick.MoveMotor('AB', -50);      
        pause(1);                       
        brick.StopAllMotors('Brake');
        brick.MoveMotorAngleRel('A', 20, angle, 'Brake');
        brick.MoveMotorAngleRel('B', 20, -angle, 'Brake');
        brick.WaitForMotor('AB');
        pause(1.35);
        tic;
        while(toc < 1.7)
        brick.MoveMotor('A', 50);
        brick.MoveMotor('B', 50);
        brick.SetColorMode(1, 2);
        color = brick.ColorCode(1);
        %display(color);
        if color == red                    
            brick.StopAllMotors('Brake');
            display("stopped");
            pause(2);
            brick.MoveMotor('AB',30);
            pause(0.5);
        end
        end
        brick.StopAllMotors('Brake');
        distance = brick.UltrasonicDist(2);
        display(distance);               
        %brick.MoveMotorAngleAbs('A', 20, 90, 'Brake');
        %brick.WaitForMotor('A');
    end  
    %Left turn code
    if distance > 40
        brick.MoveMotor('AB', 30);      
        pause(0.5);
        brick.MoveMotorAngleRel('A', 20, -angle, 'Brake');
        brick.MoveMotorAngleRel('B', 20, angle, 'Brake');
        brick.WaitForMotor('A');
        brick.WaitForMotor('B');
        pause(1.35);
        brick.StopAllMotors('Brake');
        distance = brick.UltrasonicDist(2);
        while(distance > 40)
            brick.MoveMotor('AB', 30);
            distance = brick.UltrasonicDist(2);
            touch = brick.TouchPressed(3);
            touch2 = brick.TouchPressed(4);
            if distance < 40
                pause(1.2);
            end
            if touch || touch2
                break;
            end
        end
    end
    %too close correction
    if distance < 9 
        brick.StopAllMotors('Brake');
        pause(0.5);
        brick.MoveMotor('A', 40);
        brick.MoveMotor('B', 20);
        pause(0.9)
        brick.MoveMotor('A', 20);
        brick.MoveMotor('B', 30);
        pause(0.7)
        distance = brick.UltrasonicDist(2);
        display(distance);
    end
    %too far correction
    if distance > 28 && distance < 40
        brick.StopAllMotors('Brake');
        pause(.2);
        brick.MoveMotor('A', 20);
        brick.MoveMotor('B', 40);
        pause(0.9)
        brick.MoveMotor('A', 30);
        brick.MoveMotor('B', 20);
        pause(0.7)
        distance = brick.UltrasonicDist(2);
        display(distance);       
    end
    if distance > 9 && distance < 28
        brick.MoveMotor('A', 30);
        brick.MoveMotor('B', 30);
    end    
        
        
end
brick.StopAllMotors('Brake');

