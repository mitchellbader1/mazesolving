clear all;
    brick = SimBrick(); % create a SimBrick connection to the simulator
    kbd = KeyWindow();  % create a keyboard entry window      
    logical a;
    a = true;
    while a == true
        pause(.1)
        switch kbd.key
            case 'space'
                brick.StopAllMotors; 
            case 'downarrow'
                brick.MoveMotor('AB',-100);
            case 'uparrow'
                brick.MoveMotor('AB',100);
            case 'leftarrow'
                brick.MoveMotorAngleRel('A',100,-240);
                brick.MoveMotorAngleRel('B',100,240);
            case 'rightarrow'
                brick.MoveMotorAngleRel('A',100,240);
                brick.MoveMotorAngleRel('B',100,-240);
            case 'q'
                brick.StopAllMotors
                a = false;
                break;
        end
    end
    kbd.close();        % close the keyboard entry window