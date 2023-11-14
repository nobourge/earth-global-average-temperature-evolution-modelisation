% Global Temperature Modeling (INFO-F305)
% This script contains models for simulating the global average temperature.

% Basic Energy Balance Model (EBM)
% Model to simulate the Earth's temperature using basic energy balance equations.
function basic_EBM()
    % Define constants
    R = 2.912; % Heat capacity (W-yr/m^2/K)
    Q = 342;   % Average global solar radiation (W/m^2)
    alpha = 0.3; % Albedo of the planet
    sigma = 5.67e-8; % Stefan-Boltzmann constant (W/m^2/K^4)

    % Initial temperature (Kelvin)
    T0 = 273.15; % Starting from freezing point of water

    % Time span for the simulation (in years)
    tspan = [0, 100]; % Simulate for 100 years

    % Solve differential equation using ode45
    [t, T] = ode45(@(t, T) dTdt(t, T, R, Q, alpha, sigma), tspan, T0);

    % Plot results
    plot(t, T);
    title('Global Temperature Simulation using Basic EBM');
    xlabel('Time (years)');
    ylabel('Temperature (K)');
end

% Differential equation for the basic EBM
function dT = dTdt(t, T, R, Q, alpha, sigma)
    dT = (Q * (1 - alpha) - sigma * T^4) / R;
end

% You can add more functions for other models (e.g., EBM with varying albedo)
% following the same structure: defining the model, solving it, and plotting.

% Note: Make sure to use appropriate function names and variable names 
% that reflect their purpose and significance in the model.
