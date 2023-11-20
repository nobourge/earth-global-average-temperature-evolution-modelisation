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
