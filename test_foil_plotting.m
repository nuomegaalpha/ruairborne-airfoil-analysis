%%
file = "sd7003.csv";
[~, airfoil_name, ext] = fileparts(file);
airfoil_name_caps = upper(airfoil_name);
airfoil = importdata(file);
Re = 250000;
Mach= 0.1;
% perform max 100 iterations for non converging solutions, n crit = 10
xfoil_args = 'oper iter 1000 oper/vpar n 9';
alpha = -10:0.5:20.0;
%%

[polar,foil] = xfoil(airfoil, alpha, Re, Mach, xfoil_args);

%%
f = figure();
f.Color = 'white';
f.Units = 'inches';
f.Position(3:4) = [8, 4.5];

width_scale = 1.15;
height_scale = 0.85;
line_width = 1.0;
x_offset = 0.3;
marker = 's';
line_style = '-';
label_font_size_multiplier = 1.2;
font_size = 11;

subplot(1, 2, 1)
p = plot(polar.alpha, polar.CL);
xlabel('$\alpha$ (deg)')
ylabel('$C_L$')
title("$C_L$ vs. $\alpha$")
ax = gca;
ax.Position(3) = width_scale * ax.Position(3);
ax.Position(4) = height_scale * ax.Position(4);
ax.Position(1) = ax.Position(1) - x_offset * ax.Position(1);

ax.FontSize = font_size;
ax.LabelFontSizeMultiplier = label_font_size_multiplier;
p.LineWidth = line_width;
p.LineStyle = line_style;
p.Marker = marker;

grid on

subplot(1, 2, 2)
p = plot(polar.CD, polar.CL, 'o-');
xlabel('$C_D$')
ylabel('$C_L$')
title("Drag Polar")
grid on
ax = gca;
ax.Position(3) = width_scale * ax.Position(3);
ax.Position(4) = height_scale * ax.Position(4);
ax.FontSize = font_size;
ax.LabelFontSizeMultiplier = label_font_size_multiplier;

p.LineWidth = line_width;
p.LineStyle = line_style;
p.Marker = marker;

sgtitle(airfoil_name_caps);
set(findall(f, '-property', 'Interpreter'), 'Interpreter', 'latex')
set(findall(f, '-property', 'TickLabelInterpreter'), 'TickLabelInterpreter', 'latex')