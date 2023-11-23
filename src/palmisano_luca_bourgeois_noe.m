% Global Temperature Modeling (INFO-F305)
% This script contains models for simulating the global average temperature.

%%% CONSTANTS %%%
R = 2.912;                          % Heat capacity (W-yr/m^2/K)
Q = 342;                            % Average global solar radiation (W/m^2)
alpha = 0.3;                        % Albedo of the planet
sigma = 5.67e-8;                    % Stefan-Boltzmann constant (W/m^2/K^4)
T0 = 0;                             % Starting from freezing point of water
tspan = [0, 10000];                 % Simulate for 10000 years

%%% QUESTION 1 %%%
[t, T] = ode45(@(t, T) (Q * (1 - alpha) - sigma * T^4) / R, tspan, T0);

plot(t, T);
title('Basic EBM');
xlabel('Time (years)');
ylabel('Temperature (K)');

%%% QUESTION 2 %%%
alphas = [0, 0.3, 1];
legends = cell(1, 3);
figure; % Open a new figure window
for i = 1:length(alphas)
    a = alphas(i);
    [t, T] = ode45(@(t, T) (Q * (1 - a) - sigma * T^4) / R, tspan, T0);
    legends{i} = ['α = ', num2str(a)];
    plot(t, T);
    hold on;
end
hold off;

title('EBM with varying Albedo');
legend(legends);
xlabel('Time (years)');
ylabel('Temperature (K)');

%%% QUESTION 3 %%%
% emissivity = 0
epsilon = 0.00; % Emissivity factor
figure;
[t, T] = ode45(@(t, T) (Q * (1 - alpha) - epsilon * sigma * T^4) / R, tspan, T0);
plot(t, T);
title('EBM with emissivity (ε = 0)');
xlabel('Time (years)');
ylabel('Temperature (K)');

% emissivity in [0.61, 0.76, 0.95]
epsilons = [0.61, 0.76, 0.95];
legends = cell(1, 3);
figure;
for i = 1:length(epsilons)
    e = epsilons(i);
    [t, T] = ode45(@(t, T) (Q * (1 - alpha) - e * sigma * T^4) / R, tspan, T0);
    legends{i} = ['ε = ', num2str(e)];
    plot(t, T);
    hold on;
end
hold off;

title('EBM with emissivity');
legend(legends);
xlabel('Time (years)');
ylabel('Temperature (K)');


%%% QUESTION 4 %%%
% OLR depending on Temperature in Celsius
T0 = -273.15;               % Temperature in Celsius (0K)
R = 2.912;                  % Heat capacity (W-yr/m^2/K)
A = 202;                    % Constant in W/m^2
B = 1.90;                   % Constant in W/m^2/°C

% Temperature conversion is not needed for constants A and B as they are already for °C.
% However, the temperature T in the equation must be converted from Kelvin to Celsius.
figure;
[t, T] = ode45(@(t, T) (Q * (1 - alpha) - (A + B * T)) / R, tspan, T0);
plot(t, T);
title('EBM with Temperature-Dependent OLR (in Celsius)');
xlabel('Time (years)');
ylabel('Temperature (C)');


%%% QUESTION 5 %%%
% Albedo depending on Temperature
T0 = 14.84; % Temperature in Celsius
alpha_temp = @(T) 0.5 + 0.2 * tanh(0.1 * (265 - T));

[t5, T5] = ode45(@(t, T) (Q * (1 - alpha_temp(T)) - epsilon * sigma * T^4) / R, tspan, T0);
figure; % Open a new figure window
plot(t5, T5);
title('EBM with Temperature-Dependent Albedo');
xlabel('Time (years)');
ylabel('Temperature (C)');
