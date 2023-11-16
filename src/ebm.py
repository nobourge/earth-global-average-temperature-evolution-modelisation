# Constants for the basic Energy Balance Model (EBM)
Q = 342   # Average global solar radiation (W/m^2)
alpha = 0.3 # Albedo of the planet
sigma = 5.67e-8 # Stefan-Boltzmann constant (W/m^2/K^4)

# Calculating the equilibrium temperature (Teq) of the system
# The equilibrium condition is given by Q(1 - alpha) = sigma * Teq^4

# Rearranging the equation to solve for Teq
Teq = (Q * (1 - alpha) / sigma) ** 0.25
Teq
