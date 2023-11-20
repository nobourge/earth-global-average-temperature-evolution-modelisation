% Global Temperature Modeling (INFO-F305)
% This script contains models for simulating the global average temperature.


% Define constants and initial conditions
R = 2.912; % Heat capacity (W-yr/m^2/K)
Q = 342;   % Average global solar radiation (W/m^2)
alpha = 0.3; % Albedo of the planet
sigma = 5.67e-8; % Stefan-Boltzmann constant (W/m^2/K^4)
T0 = 273.15; % Starting from freezing point of water
tspan = [0, 100]; % Simulate for 100 years

% Solve and plot for basic EBM
[t, T] = ode45(@(t, T) (Q * (1 - alpha) - sigma * T^4) / R, tspan, T0);
plot(t, T);
title('Basic EBM');
xlabel('Time (years)');
ylabel('Temperature (K)');

% Solve and plot for varying albedo
tspan = [0, 100]; % Simulate for 1000 years
alpha1 = 0;
alpha2 = 1;
[t1, T1] = ode45(@(t, T) (Q * (1 - alpha1) - sigma * T^4) / R, tspan, T0);
[t2, T2] = ode45(@(t, T) (Q * (1 - alpha2) - sigma * T^4) / R, tspan, T0);
figure; % Open a new figure window
plot(t1, T1, 'r', t2, T2, 'b');
title('EBM with Varying Albedo');
xlabel('Time (years)');
ylabel('Temperature (K)');
legend('Alpha = 0', 'Alpha = 1');

% EBM with OLR (epsilon = 0)
epsilon = 0.00; % Emissivity factor
[t3, T3] = ode45(@(t, T) (Q * (1 - alpha) - epsilon * sigma * T^4) / R, tspan, T0);
figure; % Open a new figure window
plot(t3, T3);
title('EBM with OLR (ε = 0)');
xlabel('Time (years)');
ylabel('Temperature (K)');

% EBM with OLR (different epsilon)
figure; % Open a new figure window

epsilons = [0.61, 0.76, 0.95];
legends = cell(1, 3);
for i = 1:length(epsilons)
    e = epsilons(i);
    [t, T] = ode45(@(t, T) (Q * (1 - alpha) - e * sigma * T^4) / R, tspan, T0);
    legends{i} = ['ε =', num2str(e)];
    plot(t, T);
    hold on;
end
hold off;

title('EBM with OLR');
legend(legends);
xlabel('Time (years)');
ylabel('Temperature (K)');


% OLR depending on Temperature in Celsius
T0 = 0; % Temperature in Celsius
R = 2.912; % Heat capacity (W-yr/m^2/K)
A = 202; % Constant in W/m^2
B = 1.90; % Constant in W/m^2/°C

% Temperature conversion is not needed for constants A and B as they are already for °C.
% However, the temperature T in the equation must be converted from Kelvin to Celsius.
[t4, T4] = ode45(@(t, T) (Q * (1 - alpha) - (A + B * T)) / R, tspan, T0);
figure; % Open a new figure window
plot(t4, T4);
title('EBM with Temperature-Dependent OLR (in Celsius)');
xlabel('Time (years)');
ylabel('Temperature (C)');



% Albedo depending on Temperature
T0 = 14.84; % Temperature in Celsius
alpha_temp = @(T) 0.5 + 0.2 * tanh(0.1 * (265 - T));

[t5, T5] = ode45(@(t, T) (Q * (1 - alpha_temp(T)) - epsilon * sigma * T^4) / R, tspan, T0);
figure; % Open a new figure window
plot(t5, T5);
title('EBM with Temperature-Dependent Albedo');
xlabel('Time (years)');
ylabel('Temperature (C)');
