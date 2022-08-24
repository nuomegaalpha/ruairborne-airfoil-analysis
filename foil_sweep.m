%%
clear;close all;clc
airfoil_name = ["sd7062", "sd7080", "sg6040", "e220", "sd7043"];
airfoil_name_caps = upper(airfoil_name);
Re = 340000;
Mach= 0.05;
% perform max 100 iterations for non converging solutions, n crit = 10
% xfoil_args = 'oper iter 100 oper/vpar n 10';
xfoil_args = 'oper iter 2000';
alpha = -8:0.5:18.0;
%% load data
for i = 1:length(airfoil_name)
    fprintf('Now running %s ... \n', airfoil_name(i));
    filename = sprintf('%s.csv', char(airfoil_name(i)));
    airfoil(i).name = airfoil_name(i);
    airfoil(i).filename = filename;
    airfoil(i).foil = importdata(filename);
    [polar(i),foil(i)] = xfoil(airfoil(i).foil, alpha, Re, Mach, xfoil_args);
end
%% Plot the results
f = figure();
f.Color = 'white';
f.Units = 'inches';
f.Position(3:4) = [9, 5];
f.Position(1:2) = [1, 1];
width_scale = 1.15;
height_scale = 0.85;
line_width = 0.75;
x_offset = 0.3;
marker = 'none';
line_style = '--';
label_font_size_multiplier = 1.2;
font_size = 10;
location = "southeast";

% CL vs alpha
subplot(2, 2, 1)
hold on
for i = 1:length(polar)
    p(i) = plot(polar(i).alpha, polar(i).CL, 'LineStyle',line_style, ...
        'LineWidth',line_width, 'Marker',marker, ...
        'DisplayName', upper(airfoil(i).name));
end
hold off
xlabel('$\alpha$ (deg)')
ylabel('$C_L$')
title("$C_L$ vs. $\alpha$")
ax = gca;
ax.Position(3) = width_scale * ax.Position(3);
ax.Position(4) = height_scale * ax.Position(4);
ax.Position(1) = ax.Position(1) - x_offset * ax.Position(1);
ax.FontSize = font_size;
ax.LabelFontSizeMultiplier = label_font_size_multiplier;
grid on
box on

legend(p, "Location", location)

% CL vs CD
subplot(2, 2, 2)
hold on
for i = 1:length(polar)
    plot(polar(i).CD, polar(i).CL, 'LineStyle',line_style, ...
        'LineWidth',line_width, 'Marker',marker);
end
hold off
xlabel('$C_D$')
ylabel('$C_L$')
title("Drag Polar")
ax = gca;
ax.Position(3) = width_scale * ax.Position(3);
ax.Position(4) = height_scale * ax.Position(4);
ax.FontSize = font_size;
ax.LabelFontSizeMultiplier = label_font_size_multiplier;
grid on
box on

% CM vs alpha
subplot(2, 2, 3)
hold on
for i = 1:length(polar)
    plot(polar(i).alpha, polar(i).Cm, 'LineStyle',line_style, ...
        'LineWidth',line_width, 'Marker',marker);
end
hold off
xlabel('$\alpha$ (deg)')
ylabel('$C_M$')
title("$C_M$ vs. $\alpha$")
ax = gca;
ax.Position(3) = width_scale * ax.Position(3);
ax.Position(4) = height_scale * ax.Position(4);
ax.Position(1) = ax.Position(1) - x_offset * ax.Position(1);
ax.FontSize = font_size;
ax.LabelFontSizeMultiplier = label_font_size_multiplier;
grid on
box on

% CL/CD vs alpha
subplot(2, 2, 4)
hold on
for i = 1:length(polar)
    clcd = polar(i).CL ./ polar(i).CD;
    plot(polar(i).alpha, clcd, 'LineStyle',line_style, ...
        'LineWidth',line_width, 'Marker',marker);
end
hold off
xlabel('$\alpha$ (deg)')
ylabel('$C_L / C_D$')
title("$C_L / C_D$ vs. $\alpha$")
ax = gca;
ax.Position(3) = width_scale * ax.Position(3);
ax.Position(4) = height_scale * ax.Position(4);
ax.FontSize = font_size;
ax.LabelFontSizeMultiplier = label_font_size_multiplier;
grid on
box on

% sgtitle(airfoil_name_caps);
set(findall(f, '-property', 'Interpreter'), 'Interpreter', 'latex')
set(findall(f, '-property', 'TickLabelInterpreter'), 'TickLabelInterpreter', 'latex')

%% Plot the airfoils
f = figure();
f.Color = 'white';
f.Units = 'inches';
f.Position(3:4) = [6, 4];
% f.Position(1:2) = [1, 1];
% width_scale = 1.15;
% height_scale = 0.85;
% line_width = 1.0;
x_offset = 0.3;
width_scale = 1.15;
height_scale = 0.85;
marker = 'none';
line_style = '-';
line_width = 0.75;
label_font_size_multiplier = 1.2;
font_size = 10;
location = "southeast";
hold on
for i = 1:length(polar)
    p(i) = plot(airfoil(i).foil(:,1), airfoil(i).foil(:,2), ...
        'LineStyle',line_style, ...
        'LineWidth',line_width, 'Marker',marker, ...
        'DisplayName', upper(airfoil(i).name));
end
hold off
xlabel('$x/c$')
ylabel('$y/c$')
title("Airfoil Profiles")
ax = gca;
ax.Position(3) = width_scale * ax.Position(3);
ax.Position(4) = height_scale * ax.Position(4);
ax.Position(1) = ax.Position(1) - x_offset * ax.Position(1);
ax.FontSize = font_size;
ax.LabelFontSizeMultiplier = label_font_size_multiplier;
axis(ax, 'equal')
grid on
box on
legend(p, "Location", location)
set(findall(f, '-property', 'Interpreter'), 'Interpreter', 'latex')
set(findall(f, '-property', 'TickLabelInterpreter'), 'TickLabelInterpreter', 'latex')
