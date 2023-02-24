classdef AdventureGame_exported < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        UIFigure                     matlab.ui.Figure
        TextArea                     matlab.ui.control.TextArea
        StartOverButton              matlab.ui.control.Button
        TextbasedAdventureGameLabel  matlab.ui.control.Label
        RightButton                  matlab.ui.control.Button
        LeftButton                   matlab.ui.control.Button
        DownButton                   matlab.ui.control.Button
        UpButton                     matlab.ui.control.Button
    end

    
    properties (Access = private)
        latPos % Lateral position
        verPos % Vertical position
        monster1
        monster2
        monster3
        monster4
        monster5
        treasure
        attackPoints
    end
    
    methods (Access = private)  
        function disable(app)
            app.RightButton.Visible='off';
            app.LeftButton.Visible='off';
            app.UpButton.Visible='off';
            app.DownButton.Visible='off';
        end
        
        function enable(app)
            app.RightButton.Visible='on';
            app.LeftButton.Visible='on';
            app.UpButton.Visible='on';
            app.DownButton.Visible='on';
        end
        
        function gameOver(app)
            app.disable();
        end
        
        function attack(app)
            app.disable();
            app.TextArea.Value=sprintf("You found a monster! Time to fight!");
            pause(2);
            app.TextArea.Value=sprintf("Fighting...");
            pause(2)
            app.attackPoints=randi([0 10]);
            if app.attackPoints>4
                app.TextArea.Value=sprintf("You won! Go on and find the treasure!");
                pause(1);
                app.enable();
            else
                app.TextArea.Value=sprintf("You died... Game over. Press Start Over button to try again");
                app.gameOver();
            end
        end
        
        function check(app)
            app.TextArea.Value=sprintf("There is nothing there... Go on.");
            
            if app.monster1(1)==app.latPos && app.monster1(2)==app.verPos
                app.attack();
                app.monster1=[6 6]; % We take it out the game window
            elseif app.monster2(1)==app.latPos && app.monster1(2)==app.verPos
                app.attack();
                app.monster2=[6 6]; % We take it out the game window
            elseif app.monster3(1)==app.latPos && app.monster1(2)==app.verPos
                app.attack();
                app.monster3=[6 6]; % We take it out the game window
            elseif app.monster4(1)==app.latPos && app.monster1(2)==app.verPos
                app.attack();
                app.monster4=[6 6]; % We take it out the game window
            elseif app.monster5(1)==app.latPos && app.monster1(2)==app.verPos
                app.attack();
                app.monster5=[6 6]; % We take it out the game window
            end
            
            if app.treasure(1)==app.latPos && app.treasure(2)==app.verPos
                app.TextArea.Value=sprintf("You found the treasure! You won the game! You can play again by pressing Start Over.");
                app.disable();
            end
        end
    end
    

    % Callbacks that handle component events
    methods (Access = private)

        % Code that executes after component creation
        function startupFcn(app)
            % Give positions to monsters and items
            app.monster1=[randi([0 5]),randi([0 5])];
            app.monster2=[randi([0 5]),randi([0 5])];
            app.monster3=[randi([0 5]),randi([0 5])];
            app.monster4=[randi([0 5]),randi([0 5])];
            app.monster5=[randi([0 5]),randi([0 5])];
            app.treasure=[randi([0 5]),randi([0 5])]; % Find the treasure to win
            
            % Give starting position to the player
            app.latPos=0;
            app.verPos=0;
            
            % Enable buttons
            app.enable();
            
            % Starting text
            app.TextArea.Value=sprintf("There is nothing there... Go on.");
        end

        % Button pushed function: RightButton
        function RightButtonPushed(app, event)
            if app.latPos~=5
                app.latPos=app.latPos+1; %Increase the position in one point
                app.check() % Check if there is something in the new position
            else
                app.TextArea.Value=sprintf("There is a wall to your right... You can't go that way.");
            end
        end

        % Button pushed function: LeftButton
        function LeftButtonPushed(app, event)
            if app.latPos~=0
                app.latPos=app.latPos-1; %Increase the position in one point
                app.check() % Check if there is something in the new position
            else
                app.TextArea.Value=sprintf("There is a wall to your left... You can't go that way.");
            end         
        end

        % Button pushed function: DownButton
        function DownButtonPushed(app, event)
            if app.verPos~=0
                app.verPos=app.verPos-1; %Increase the position in one point
                app.check() % Check if there is something in the new position
            else
                app.TextArea.Value=sprintf("There is a wall down there... You can't go that way.");
            end  
        end

        % Button pushed function: UpButton
        function UpButtonPushed(app, event)
            if app.verPos~=5
                app.verPos=app.verPos+1; %Increase the position in one point
                app.check() % Check if there is something in the new position
            else
                app.TextArea.Value=sprintf("There is a wall up there... You can't go that way.");
            end  
        end

        % Button pushed function: StartOverButton
        function StartOverButtonPushed(app, event)
            app.startupFcn();
        end
    end

    % Component initialization
    methods (Access = private)

        % Create UIFigure and components
        function createComponents(app)

            % Create UIFigure and hide until all components are created
            app.UIFigure = uifigure('Visible', 'off');
            app.UIFigure.Color = [0.0902 0.2196 0.251];
            app.UIFigure.Position = [100 100 640 480];
            app.UIFigure.Name = 'MATLAB App';

            % Create UpButton
            app.UpButton = uibutton(app.UIFigure, 'push');
            app.UpButton.ButtonPushedFcn = createCallbackFcn(app, @UpButtonPushed, true);
            app.UpButton.BackgroundColor = [0.6627 0.7765 0.851];
            app.UpButton.Position = [292 90 58 22];
            app.UpButton.Text = 'Up';

            % Create DownButton
            app.DownButton = uibutton(app.UIFigure, 'push');
            app.DownButton.ButtonPushedFcn = createCallbackFcn(app, @DownButtonPushed, true);
            app.DownButton.BackgroundColor = [0.6627 0.7765 0.851];
            app.DownButton.Position = [292 69 58 22];
            app.DownButton.Text = 'Down';

            % Create LeftButton
            app.LeftButton = uibutton(app.UIFigure, 'push');
            app.LeftButton.ButtonPushedFcn = createCallbackFcn(app, @LeftButtonPushed, true);
            app.LeftButton.BackgroundColor = [0.6627 0.7765 0.851];
            app.LeftButton.Position = [235 69 58 22];
            app.LeftButton.Text = 'Left';

            % Create RightButton
            app.RightButton = uibutton(app.UIFigure, 'push');
            app.RightButton.ButtonPushedFcn = createCallbackFcn(app, @RightButtonPushed, true);
            app.RightButton.BackgroundColor = [0.6627 0.7765 0.851];
            app.RightButton.Position = [349 69 58 22];
            app.RightButton.Text = 'Right';

            % Create TextbasedAdventureGameLabel
            app.TextbasedAdventureGameLabel = uilabel(app.UIFigure);
            app.TextbasedAdventureGameLabel.HorizontalAlignment = 'center';
            app.TextbasedAdventureGameLabel.FontName = 'Calibri Light';
            app.TextbasedAdventureGameLabel.FontSize = 40;
            app.TextbasedAdventureGameLabel.FontWeight = 'bold';
            app.TextbasedAdventureGameLabel.FontColor = [0.4 0.7216 0.851];
            app.TextbasedAdventureGameLabel.Position = [87 377 467 54];
            app.TextbasedAdventureGameLabel.Text = 'Text-based Adventure Game';

            % Create StartOverButton
            app.StartOverButton = uibutton(app.UIFigure, 'push');
            app.StartOverButton.ButtonPushedFcn = createCallbackFcn(app, @StartOverButtonPushed, true);
            app.StartOverButton.BackgroundColor = [0.749 0.0824 0.3255];
            app.StartOverButton.Position = [526 17 100 22];
            app.StartOverButton.Text = 'Start Over';

            % Create TextArea
            app.TextArea = uitextarea(app.UIFigure);
            app.TextArea.Editable = 'off';
            app.TextArea.FontSize = 24;
            app.TextArea.BackgroundColor = [0.6627 0.7765 0.851];
            app.TextArea.Position = [83 204 477 82];

            % Show the figure after all components are created
            app.UIFigure.Visible = 'on';
        end
    end

    % App creation and deletion
    methods (Access = public)

        % Construct app
        function app = AdventureGame_exported

            % Create UIFigure and components
            createComponents(app)

            % Register the app with App Designer
            registerApp(app, app.UIFigure)

            % Execute the startup function
            runStartupFcn(app, @startupFcn)

            if nargout == 0
                clear app
            end
        end

        % Code that executes before app deletion
        function delete(app)

            % Delete UIFigure when app is deleted
            delete(app.UIFigure)
        end
    end
end