//
//  HeatUnitsModel.swift
//  UnitConverter
//
//  Created by Burak Albayrak on 3.09.2024.
//

import Foundation

enum HeatUnitsCategory: String, CaseIterable, UnitCategory {
    case fuelEfficiencyMass = "Fuel Efficiency - Mass"
    case fuelEfficiencyVolume = "Fuel Efficiency - Volume"
    case temperatureInterval = "Temperature Interval"
    case thermalExpansion = "Thermal Expansion"
    case thermalResistance = "Thermal Resistance"
    case thermalConductivity = "Thermal Conductivity"
    case spesificHeatCapacity = "Spesific Heat Capacity"
    case heatDensity = "Heat Density"
    case heatFluxDensity = "Heat Flux Density"
    case heatTransverCoefficient = "Heat Transver Coefficient"

    func convert(_ value: Decimal, from fromUnit: String, to toUnit: String) -> Decimal {
        switch self {
        case .fuelEfficiencyMass:
            return convertSpecificEnergy(value, from: fromUnit, to: toUnit)
        case .fuelEfficiencyVolume:
            return convertEnergyDensity(value, from: fromUnit, to: toUnit)
        case .temperatureInterval:
            return convertTemperature(value, from: fromUnit, to: toUnit)
        case .thermalExpansion:
            return convertThermalExpansionCoefficient(value, from: fromUnit, to: toUnit)
        case .thermalResistance:
            return convertThermalResistance(value, from: fromUnit, to: toUnit)
        case .thermalConductivity:
            return convertThermalConductivity(value, from: fromUnit, to: toUnit)
        case .spesificHeatCapacity:
            return convertSpecificHeatCapacity(value, from: fromUnit, to: toUnit)
        case .heatDensity:
            return convertRadiationEnergyDensity(value, from: fromUnit, to: toUnit)
        case .heatFluxDensity:
            return convertRadiationFluxDensity(value, from: fromUnit, to: toUnit)
        case .heatTransverCoefficient:
            return convertHeatTransferCoefficient(value, from: fromUnit, to: toUnit)
        }
    }
    
    private func convertSpecificEnergy(_ value: Decimal, from fromUnit: String, to toUnit: String) -> Decimal {
        let joulePerKilogramValues: [String: Decimal] = [
            "joule/kilogram": 1,
            "kilojoule/kilogram": 1000,
            "calorie (IT)/gram": Decimal(string: "4186.8")!,
            "calorie (th)/gram": Decimal(string: "4184.000000005")!,
            "Btu (IT)/pound": 2326,
            "Btu (th)/pound": Decimal(string: "2324.4444444446")!,
            "kilogram/joule": 1,
            "kilogram/kilojoule": 1000,
            "gram/calorie (IT)": Decimal(string: "4186.8")!,
            "gram/calorie (th)": Decimal(string: "4184.000000005")!,
            "pound/Btu (IT)": 2326,
            "pound/Btu (th)": Decimal(string: "2324.4444444446")!,
            "pound/horsepower/hour": Decimal(string: "5918352.5016")!,
            "gram/horsepower (metric)/hour": 2647795500,
            "gram/kilowatt/hour": 3600000000
        ]

        guard let fromValue = joulePerKilogramValues[fromUnit.lowercased()], let toValue = joulePerKilogramValues[toUnit.lowercased()] else {
            return value
        }

        let joulePerKilogram = value * fromValue
        return joulePerKilogram / toValue
    }
    
    private func convertEnergyDensity(_ value: Decimal, from fromUnit: String, to toUnit: String) -> Decimal {
        let joulePerCubicMeterValues: [String: Decimal] = [
            "joule/cubic meter": 1,
            "joule/liter": 1000,
            "megajoule/cubic meter": 1000000,
            "kilojoule/cubic meter": 1000,
            "kilocalorie (IT)/cubic meter": Decimal(string: "4186.800000482")!,
            "calorie (IT)/cubic centimeter": Decimal(string: "4186800.000482")!,
            "therm/cubic foot": Decimal(string: "3725894617.319")!,
            "therm/gallon (UK)": Decimal(string: "23207984510.267")!,
            "Btu (IT)/cubic foot": Decimal(string: "37258.945807808")!,
            "Btu (th)/cubic foot": Decimal(string: "37234.028198186")!,
            "CHU/cubic foot": Decimal(string: "67066.103121737")!,
            "cubic meter/joule": 1,
            "liter/joule": 1000,
            "gallon (US)/horsepower": Decimal(string: "709175035.869")!
        ]

        guard let fromValue = joulePerCubicMeterValues[fromUnit.lowercased()], let toValue = joulePerCubicMeterValues[toUnit.lowercased()] else {
            return value
        }

        let joulePerCubicMeter = value * fromValue
        return joulePerCubicMeter / toValue
    }
    
    private func convertTemperature(_ value: Decimal, from fromUnit: String, to toUnit: String) -> Decimal {
        let kelvin: Decimal
        
        switch fromUnit.lowercased() {
        case "kelvin", "k":
            kelvin = value
        case "degree celsius", "°c", "degree centigrade":
            kelvin = value + Decimal(273.15)
        case "degree fahrenheit", "°f":
            kelvin = (value - 32) * 5/9 + Decimal(273.15)
        case "degree rankine", "°r":
            kelvin = value * 5/9
        case "degree reaumur", "°re":
            kelvin = value * Decimal(1.25) + Decimal(273.15)
        default:
            return value
        }
        
        switch toUnit.lowercased() {
        case "kelvin", "k":
            return kelvin
        case "degree celsius", "°c", "degree centigrade":
            return kelvin - Decimal(273.15)
        case "degree fahrenheit", "°f":
            return (kelvin - Decimal(273.15)) * 9/5 + 32
        case "degree rankine", "°r":
            return kelvin * Decimal(1.8)
        case "degree reaumur", "°re":
            return (kelvin - Decimal(273.15)) * Decimal(0.8)
        default:
            return value
        }
    }
    
    private func convertThermalExpansionCoefficient(_ value: Decimal, from fromUnit: String, to toUnit: String) -> Decimal {
        let perKelvinValues: [String: Decimal] = [
            "length/length/kelvin": 1,
            "length/length/degree celsius": 1,
            "length/length/degree fahrenheit": Decimal(1.8),
            "length/length/degree rankine": Decimal(1.8),
            "length/length/degree reaumur": Decimal(0.8)
        ]

        guard let fromValue = perKelvinValues[fromUnit.lowercased()], let toValue = perKelvinValues[toUnit.lowercased()] else {
            return value
        }

        let perKelvin = value * fromValue
        return perKelvin / toValue
    }
    
    private func convertThermalResistance(_ value: Decimal, from fromUnit: String, to toUnit: String) -> Decimal {
        let kelvinPerWattValues: [String: Decimal] = [
            "kelvin/watt": 1,
            "degree fahrenheit hour/btu (it)": Decimal(string: "1.8956342406")!,
            "degree fahrenheit hour/btu (th)": Decimal(string: "1.8969028295")!,
            "degree fahrenheit second/btu (it)": Decimal(string: "0.0005265651")!,
            "degree fahrenheit second/btu (th)": Decimal(string: "0.0005269175")!
        ]

        guard let fromValue = kelvinPerWattValues[fromUnit.lowercased()], let toValue = kelvinPerWattValues[toUnit.lowercased()] else {
            return value
        }

        let kelvinPerWatt = value * fromValue
        return kelvinPerWatt / toValue
    }
    
    private func convertThermalConductivity(_ value: Decimal, from fromUnit: String, to toUnit: String) -> Decimal {
        let wattPerMeterKelvinValues: [String: Decimal] = [
            "watt/meter/K": 1,
            "watt/centimeter/°C": 100,
            "kilowatt/meter/K": 1000,
            "calorie (IT)/second/cm/°C": Decimal(string: "418.6800000009")!,
            "calorie (th)/second/cm/°C": Decimal(string: "418.3999999994")!,
            "kilocalorie (IT)/hour/meter/°C": Decimal(string: "1.163")!,
            "kilocalorie (th)/hour/meter/°C": Decimal(string: "1.1622222222")!,
            "Btu (IT) inch/second/sq. foot/°F": Decimal(string: "519.2203999105")!,
            "Btu (th) inch/second/sq. foot/°F": Decimal(string: "518.8731616576")!,
            "Btu (IT) foot/hour/sq. foot/°F": Decimal(string: "1.7307346664")!,
            "Btu (th) foot/hour/sq. foot/°F": Decimal(string: "1.7295772055")!,
            "Btu (IT) inch/hour/sq. foot/°F": Decimal(string: "0.1442278889")!,
            "Btu (th) inch/hour/sq. foot/°F": Decimal(string: "0.1441314338")!
        ]

        guard let fromValue = wattPerMeterKelvinValues[fromUnit.lowercased()], let toValue = wattPerMeterKelvinValues[toUnit.lowercased()] else {
            return value
        }

        let wattPerMeterKelvin = value * fromValue
        return wattPerMeterKelvin / toValue
    }
    
    private func convertSpecificHeatCapacity(_ value: Decimal, from fromUnit: String, to toUnit: String) -> Decimal {
        let joulePerKilogramKelvinValues: [String: Decimal] = [
            "joule/kilogram/K": 1,
            "joule/kilogram/°C": 1,
            "joule/gram/°C": 1000,
            "kilojoule/kilogram/K": 1000,
            "kilojoule/kilogram/°C": 1000,
            "calorie (IT)/gram/°C": Decimal(string: "4186.8000000087")!,
            "calorie (IT)/gram/°F": Decimal(string: "4186.8000000087")!,
            "calorie (th)/gram/°C": 4184,
            "kilocalorie (IT)/kilogram/°C": Decimal(string: "4186.8000000087")!,
            "kilocalorie (th)/kilogram/°C": 4184,
            "kilocalorie (IT)/kilogram/K": Decimal(string: "4186.8000000087")!,
            "kilocalorie (th)/kilogram/K": 4184,
            "kilogram-force meter/kilogram/K": Decimal(string: "9.80665")!,
            "pound-force foot/pound/°R": Decimal(string: "5.380320456")!,
            "Btu (IT)/pound/°F": Decimal(string: "4186.8000000087")!,
            "Btu (th)/pound/°F": 4184,
            "Btu (IT)/pound/°R": Decimal(string: "4186.8000000087")!,
            "Btu (th)/pound/°R": 4184,
            "Btu (IT)/pound/°C": Decimal(string: "2326.0000001596")!,
            "CHU/pound/°C": Decimal(string: "4186.800000482")!
        ]

        guard let fromValue = joulePerKilogramKelvinValues[fromUnit.lowercased()], let toValue = joulePerKilogramKelvinValues[toUnit.lowercased()] else {
            return value
        }

        let joulePerKilogramKelvin = value * fromValue
        return joulePerKilogramKelvin / toValue
    }
    
    private func convertRadiationEnergyDensity(_ value: Decimal, from fromUnit: String, to toUnit: String) -> Decimal {
        let joulePerSquareMeterValues: [String: Decimal] = [
            "joule/square meter": 1,
            "calorie (th)/square centimeter": Decimal(string: "41839.999999999")!,
            "langley": Decimal(string: "41839.999999999")!,
            "Btu (IT)/square foot": Decimal(string: "11356.526682227")!,
            "Btu (th)/square foot": Decimal(string: "11348.931794793")!
        ]

        guard let fromValue = joulePerSquareMeterValues[fromUnit.lowercased()], let toValue = joulePerSquareMeterValues[toUnit.lowercased()] else {
            return value
        }

        let joulePerSquareMeter = value * fromValue
        return joulePerSquareMeter / toValue
    }
    
    private func convertRadiationFluxDensity(_ value: Decimal, from fromUnit: String, to toUnit: String) -> Decimal {
        let wattPerSquareMeterValues: [String: Decimal] = [
            "watt/square meter": 1,
            "kilowatt/square meter": 1000,
            "watt/square centimeter": 10000,
            "watt/square inch": Decimal(string: "1550.0031012075")!,
            "joule/second/square meter": 1,
            "kilocalorie (IT)/hour/square meter": Decimal(string: "1.1629999999")!,
            "kilocalorie (IT)/hour/square foot": Decimal(string: "12.5184278205")!,
            "calorie (IT)/second/square centimeter": Decimal(string: "41868.00000482")!,
            "calorie (IT)/minute/square centimeter": Decimal(string: "697.8000000803")!,
            "calorie (IT)/hour/square centimeter": Decimal(string: "11.6300000008")!,
            "calorie (th)/second/square centimeter": Decimal(string: "41839.999999942")!,
            "calorie (th)/minute/square centimeter": Decimal(string: "697.3333333314")!,
            "calorie (th)/hour/square centimeter": Decimal(string: "11.6222222222")!,
            "dyne/hour/centimeter": Decimal(string: "2.7777777777778E-7")!,
            "erg/hour/square millimeter": Decimal(string: "2.77778E-5")!,
            "foot pound/minute/square foot": Decimal(string: "0.2432317156")!,
            "horsepower/square foot": Decimal(string: "8026.6466174305")!,
            "horsepower (metric)/square foot": Decimal(string: "7916.8426564296")!,
            "Btu (IT)/second/square foot": Decimal(string: "11356.526682221")!,
            "Btu (IT)/minute/square foot": Decimal(string: "189.2754465477")!,
            "Btu (IT)/hour/square foot": Decimal(string: "3.1545907451")!,
            "Btu (th)/second/square inch": Decimal(string: "1634246.1784508")!,
            "Btu (th)/second/square foot": Decimal(string: "11348.93179479")!,
            "Btu (th)/minute/square foot": Decimal(string: "189.1488632466")!,
            "Btu (th)/hour/square foot": Decimal(string: "3.1524810541")!,
            "CHU/hour/square foot": Decimal(string: "5.6782633986")!
        ]

        guard let fromValue = wattPerSquareMeterValues[fromUnit.lowercased()], let toValue = wattPerSquareMeterValues[toUnit.lowercased()] else {
            return value
        }

        let wattPerSquareMeter = value * fromValue
        return wattPerSquareMeter / toValue
    }
    
    private func convertHeatTransferCoefficient(_ value: Decimal, from fromUnit: String, to toUnit: String) -> Decimal {
        let wattPerSquareMeterKelvinValues: [String: Decimal] = [
            "watt/square meter/K": 1,
            "watt/square meter/°C": 1,
            "joule/second/square meter/K": 1,
            "calorie (IT)/second/square centimeter/°C": Decimal(string: "41868.00000482")!,
            "kilocalorie (IT)/hour/square meter/°C": Decimal(string: "1.163")!,
            "kilocalorie (IT)/hour/square foot/°C": Decimal(string: "12.5184278205")!,
            "Btu (IT)/second/square foot/°F": Decimal(string: "20441.748028012")!,
            "Btu (th)/second/square foot/°F": Decimal(string: "20428.077230618")!,
            "Btu (IT)/hour/square foot/°F": Decimal(string: "5.6782633411")!,
            "Btu (th)/hour/square foot/°F": Decimal(string: "5.6744658974")!,
            "CHU/hour/square foot/°C": Decimal(string: "5.6782633411")!
        ]

        guard let fromValue = wattPerSquareMeterKelvinValues[fromUnit.lowercased()], let toValue = wattPerSquareMeterKelvinValues[toUnit.lowercased()] else {
            return value
        }

        let wattPerSquareMeterKelvin = value * fromValue
        return wattPerSquareMeterKelvin / toValue
    }
    
    var icon: String {
        switch self {
        case .fuelEfficiencyMass:
            return "gauge"
        case .fuelEfficiencyVolume:
            return "fuelpump"
        case .heatDensity:
            return "flame"
        case .heatFluxDensity:
            return "waveform.path.badge.plus"
        case .heatTransverCoefficient:
            return "thermometer"
        case .spesificHeatCapacity:
            return "flame.circle"
        case .temperatureInterval:
            return "thermometer.sun"
        case .thermalConductivity:
            return "waveform.path"
        case .thermalExpansion:
            return "arrow.up.right.circle"
        case .thermalResistance:
            return "snowflake"
        }
    }
    
    var info: String {
        switch self {
        case .fuelEfficiencyMass:
            return """
                Fuel efficiency mass measures the amount of fuel consumed per unit of mass of a vehicle or engine. It indicates how effectively a vehicle converts fuel into energy relative to its mass, and is typically expressed in units such as liters per 100 kilograms (L/100 kg) or gallons per ton (gal/ton). 
                
                For example, if a vehicle has a fuel efficiency mass of 0.5 L/100 kg, it means that 0.5 liters of fuel are used for every 100 kilograms of the vehicle’s mass.
                
                This metric is important for assessing and comparing the efficiency of different vehicles or engines, influencing fuel economy and operational costs.
                
                Accurate evaluation of fuel efficiency mass helps in optimizing vehicle performance, reducing environmental impact, and making informed decisions regarding vehicle design and usage.
                """
        case .fuelEfficiencyVolume:
            return """
                Fuel efficiency volume measures the amount of fuel consumed per unit of volume of a vehicle or engine. It indicates how effectively a vehicle uses fuel relative to its volume, and is typically expressed in units such as liters per 100 liters (L/100 L) or gallons per cubic meter (gal/m³).
                
                For example, if a vehicle has a fuel efficiency volume of 10 L/100 L, it means that 10 liters of fuel are consumed for every 100 liters of the vehicle's volume.
                
                This metric is important for evaluating and comparing the fuel consumption of different vehicles or engines, particularly in applications where space constraints are a factor.
                
                Accurate assessment of fuel efficiency volume is crucial for optimizing fuel use, reducing operational costs, and making informed choices about vehicle design and performance.
                """
        case .heatDensity:
            return """
                Heat density, also known as thermal energy density, measures the amount of heat energy stored per unit volume of a material or system. It is typically expressed in units such as joules per cubic meter (J/m³).
                
                For example, a material with a heat density of 5000 J/m³ means that there are 5000 joules of heat energy contained within each cubic meter of the material.
                
                Heat density is crucial in various applications, including thermal management, energy storage, and materials science, as it helps in assessing how much heat a substance can store or release.
                
                Understanding and measuring heat density is essential for designing efficient thermal systems, optimizing energy storage solutions, and managing heat distribution in processes and devices.
                """
        case .heatFluxDensity:
            return """
                Heat flux density measures the rate at which heat energy is transferred through a unit area of a material. It quantifies the intensity of heat flow per unit area and is typically expressed in watts per square meter (W/m²).
                
                For example, a heat flux density of 500 W/m² indicates that 500 watts of heat energy pass through each square meter of the material.
                
                This metric is crucial in fields such as thermal engineering, building design, and materials science, as it helps in understanding and managing heat transfer processes.
                
                Accurate measurement of heat flux density is essential for designing effective thermal insulation, optimizing heat exchangers, and ensuring proper temperature control in various applications.
                """
        case .heatTransverCoefficient:
            return """
                The heat transfer coefficient quantifies the rate at which heat is transferred between a solid surface and a fluid (liquid or gas) in contact with it. It is typically expressed in watts per square meter per degree Celsius (W/m²°C) or watts per square meter per kelvin (W/m²·K).
                
                For example, a heat transfer coefficient of 100 W/m²·K means that for each degree Celsius (or kelvin) difference in temperature, 100 watts of heat are transferred through each square meter of the surface.
                
                This coefficient is crucial in designing and optimizing systems involving heat exchange, such as radiators, heat exchangers, and cooling systems.
                
                Accurate measurement and understanding of the heat transfer coefficient are essential for improving thermal efficiency, ensuring effective cooling or heating, and enhancing overall system performance in various industrial and engineering applications.
                """
        case .spesificHeatCapacity:
            return """
                Specific heat capacity is the amount of heat required to raise the temperature of a unit mass of a substance by one degree Celsius (or one kelvin). It is expressed in units such as joules per kilogram per degree Celsius (J/kg·°C) or joules per kilogram per kelvin (J/kg·K).
                
                For example, the specific heat capacity of water is approximately 4,186 J/kg·K, meaning it takes 4,186 joules to raise the temperature of one kilogram of water by one kelvin.
                
                Specific heat capacity is crucial in thermodynamics and heat transfer, as it determines how a substance reacts to heat and affects processes such as heating, cooling, and phase changes.
                
                Accurate knowledge of specific heat capacity is essential for designing thermal systems, calculating energy requirements, and understanding material behavior in various scientific and engineering applications.
                """
        case .temperatureInterval:
            return """
                Temperature interval refers to the range of temperatures between two specified points. It is often used to describe the difference in temperature between two conditions or the span of temperatures over which a process or reaction occurs.
                
                The interval is expressed in degrees Celsius (°C) or Kelvin (K). For example, if a system operates between 20°C and 80°C, the temperature interval is 60°C.
                
                Understanding and measuring temperature intervals are crucial in various fields such as engineering, meteorology, and chemistry, as it helps in monitoring and controlling processes, ensuring safety, and optimizing performance. Accurate assessment of temperature intervals is essential for designing equipment, conducting experiments, and managing temperature-sensitive materials.
                """
        case .thermalConductivity:
            return """
                Thermal conductivity measures a material's ability to conduct heat. It quantifies the rate at which heat flows through a material per unit area per unit temperature gradient.
                
                The SI unit for thermal conductivity is watts per meter per degree Celsius (W/m·°C) or watts per meter per kelvin (W/m·K).
                
                For example, materials like copper have high thermal conductivity, meaning they transfer heat efficiently, while materials like rubber have low thermal conductivity, acting as effective insulators.
                
                Thermal conductivity is crucial in fields such as materials science, engineering, and building construction, influencing the design of thermal insulation, heat exchangers, and electronic cooling systems.
                
                Accurate measurement of thermal conductivity helps in selecting appropriate materials for thermal management and ensuring energy efficiency in various applications.
                """
        case .thermalExpansion:
            return """
                Thermal expansion refers to the increase in volume or length of a material as its temperature rises. It occurs because most materials expand when heated due to the increased vibration of their atoms or molecules.
                
                The degree of expansion is characterized by the coefficient of thermal expansion, which is typically expressed in units such as per degree Celsius (1/°C) or per kelvin (1/K).
                
                For example, if a metal rod has a coefficient of thermal expansion of 12 × 10⁻⁶ /°C, its length will increase by 12 micrometers for every meter of length for each degree Celsius increase in temperature.
                
                Understanding and measuring thermal expansion is crucial in engineering and construction, as it helps in designing structures and materials that can accommodate temperature-induced changes, preventing damage and ensuring structural integrity.
                """
        case .thermalResistance:
            return """
                Thermal resistance measures a material's ability to resist the flow of heat. It quantifies how well a material or assembly insulates against heat transfer and is the inverse of thermal conductivity.
                
                The SI unit for thermal resistance is square meters Kelvin per watt (m²·K/W).
                
                For example, if a material has a thermal resistance of 2 m²·K/W, it means that 1 watt of heat is conducted through 2 square meters of the material for each degree Kelvin of temperature difference.
                
                Thermal resistance is crucial in building construction, electronics, and thermal management applications, as it helps in designing insulation, optimizing heat dissipation, and enhancing energy efficiency.
                
                Accurate measurement of thermal resistance is essential for selecting appropriate materials and ensuring effective thermal control in various systems and environments.
                """
        }
    }
    
    var availableUnits: [(symbol: String, name: String)] {
        switch self {
        case .fuelEfficiencyMass:
            return [
                ("J/kg", "joule/kilogram"),
                ("kJ/kg", "kilojoule/kilogram"),
                ("cal(IT)/g", "calorie (IT)/gram"),
                ("cal(th)/g", "calorie (th)/gram"),
                ("Btu(IT)/lb", "Btu (IT)/pound"),
                ("Btu(th)/lb", "Btu (th)/pound"),
                ("kg/J", "kilogram/joule"),
                ("kg/kJ", "kilogram/kilojoule"),
                ("g/cal(IT)", "gram/calorie (IT)"),
                ("g/cal(th)", "gram/calorie (th)"),
                ("lb/Btu(IT)", "pound/Btu (IT)"),
                ("lb/Btu(th)", "pound/Btu (th)"),
                ("lb/hp/h", "pound/horsepower/hour"),
                ("g/hp(m)/h", "gram/horsepower (metric)/hour"),
                ("g/kW/h", "gram/kilowatt/hour")
            ]
        case .fuelEfficiencyVolume:
            return [
                ("J/m³", "joule/cubic meter"),
                ("J/L", "joule/liter"),
                ("MJ/m³", "megajoule/cubic meter"),
                ("kJ/m³", "kilojoule/cubic meter"),
                ("kcal(IT)/m³", "kilocalorie (IT)/cubic meter"),
                ("cal(IT)/cm³", "calorie (IT)/cubic centimeter"),
                ("therm/ft³", "therm/cubic foot"),
                ("therm/gal(UK)", "therm/gallon (UK)"),
                ("Btu(IT)/ft³", "Btu (IT)/cubic foot"),
                ("Btu(th)/ft³", "Btu (th)/cubic foot"),
                ("CHU/ft³", "CHU/cubic foot"),
                ("m³/J", "cubic meter/joule"),
                ("L/J", "liter/joule"),
                ("gal(US)/hp", "gallon (US)/horsepower")
            ]
        case .temperatureInterval:
            return [
                ("K", "kelvin"),
                ("°C", "degree Celsius"),
                ("°C", "degree centigrade"),
                ("°F", "degree Fahrenheit"),
                ("°R", "degree Rankine"),
                ("°Ré", "degree Reaumur")
            ]
        case .thermalExpansion:
            return [
                ("1/K", "length/length/kelvin"),
                ("1/°C", "length/length/degree Celsius"),
                ("1/°F", "length/length/degree Fahrenheit"),
                ("1/°R", "length/length/degree Rankine"),
                ("1/°Ré", "length/length/degree Reaumur")
            ]
        case .thermalResistance:
            return [
                ("K/W", "kelvin/watt"),
                ("°F·h/Btu(IT)", "degree Fahrenheit hour/Btu (IT)"),
                ("°F·h/Btu(th)", "degree Fahrenheit hour/Btu (th)"),
                ("°F·s/Btu(IT)", "degree Fahrenheit second/Btu (IT)"),
                ("°F·s/Btu(th)", "degree Fahrenheit second/Btu (th)")
            ]
        case .thermalConductivity:
            return [
                ("W/m·K", "watt/meter/K"),
                ("W/cm·°C", "watt/centimeter/°C"),
                ("kW/m·K", "kilowatt/meter/K"),
                ("cal(IT)/s·cm·°C", "calorie (IT)/second/cm/°C"),
                ("cal(th)/s·cm·°C", "calorie (th)/second/cm/°C"),
                ("kcal(IT)/h·m·°C", "kilocalorie (IT)/hour/meter/°C"),
                ("kcal(th)/h·m·°C", "kilocalorie (th)/hour/meter/°C"),
                ("Btu(IT)·in/s·ft²·°F", "Btu (IT) inch/second/sq. foot/°F"),
                ("Btu(th)·in/s·ft²·°F", "Btu (th) inch/second/sq. foot/°F"),
                ("Btu(IT)·ft/h·ft²·°F", "Btu (IT) foot/hour/sq. foot/°F"),
                ("Btu(th)·ft/h·ft²·°F", "Btu (th) foot/hour/sq. foot/°F"),
                ("Btu(IT)·in/h·ft²·°F", "Btu (IT) inch/hour/sq. foot/°F"),
                ("Btu(th)·in/h·ft²·°F", "Btu (th) inch/hour/sq. foot/°F")
            ]
        case .spesificHeatCapacity:
            return [
                ("J/kg·K", "joule/kilogram/K"),
                ("J/kg·°C", "joule/kilogram/°C"),
                ("J/g·°C", "joule/gram/°C"),
                ("kJ/kg·K", "kilojoule/kilogram/K"),
                ("kJ/kg·°C", "kilojoule/kilogram/°C"),
                ("cal(IT)/g·°C", "calorie (IT)/gram/°C"),
                ("cal(IT)/g·°F", "calorie (IT)/gram/°F"),
                ("cal(th)/g·°C", "calorie (th)/gram/°C"),
                ("kcal(IT)/kg·°C", "kilocalorie (IT)/kilogram/°C"),
                ("kcal(th)/kg·°C", "kilocalorie (th)/kilogram/°C"),
                ("kcal(IT)/kg·K", "kilocalorie (IT)/kilogram/K"),
                ("kcal(th)/kg·K", "kilocalorie (th)/kilogram/K"),
                ("kgf·m/kg·K", "kilogram-force meter/kilogram/K"),
                ("lbf·ft/lb·°R", "pound-force foot/pound/°R"),
                ("Btu(IT)/lb·°F", "Btu (IT)/pound/°F"),
                ("Btu(th)/lb·°F", "Btu (th)/pound/°F"),
                ("Btu(IT)/lb·°R", "Btu (IT)/pound/°R"),
                ("Btu(th)/lb·°R", "Btu (th)/pound/°R"),
                ("Btu(IT)/lb·°C", "Btu (IT)/pound/°C"),
                ("CHU/lb·°C", "CHU/pound/°C")
            ]
        case .heatDensity:
            return [
                ("J/m²", "joule/square meter"),
                ("cal(th)/cm²", "calorie (th)/square centimeter"),
                ("Ly", "langley"),
                ("Btu(IT)/ft²", "Btu (IT)/square foot"),
                ("Btu(th)/ft²", "Btu (th)/square foot")
            ]
        case .heatFluxDensity:
            return [
                ("W/m²", "watt/square meter"),
                ("kW/m²", "kilowatt/square meter"),
                ("W/cm²", "watt/square centimeter"),
                ("W/in²", "watt/square inch"),
                ("J/s·m²", "joule/second/square meter"),
                ("kcal(IT)/h·m²", "kilocalorie (IT)/hour/square meter"),
                ("kcal(IT)/h·ft²", "kilocalorie (IT)/hour/square foot"),
                ("cal(IT)/s·cm²", "calorie (IT)/second/square centimeter"),
                ("cal(IT)/min·cm²", "calorie (IT)/minute/square centimeter"),
                ("cal(IT)/h·cm²", "calorie (IT)/hour/square centimeter"),
                ("cal(th)/s·cm²", "calorie (th)/second/square centimeter"),
                ("cal(th)/min·cm²", "calorie (th)/minute/square centimeter"),
                ("cal(th)/h·cm²", "calorie (th)/hour/square centimeter"),
                ("dyn/h·cm", "dyne/hour/centimeter"),
                ("erg/h·mm²", "erg/hour/square millimeter"),
                ("ft·lb/min·ft²", "foot pound/minute/square foot"),
                ("hp/ft²", "horsepower/square foot"),
                ("hp(m)/ft²", "horsepower (metric)/square foot"),
                ("Btu(IT)/s·ft²", "Btu (IT)/second/square foot"),
                ("Btu(IT)/min·ft²", "Btu (IT)/minute/square foot"),
                ("Btu(IT)/h·ft²", "Btu (IT)/hour/square foot"),
                ("Btu(th)/s·in²", "Btu (th)/second/square inch"),
                ("Btu(th)/s·ft²", "Btu (th)/second/square foot"),
                ("Btu(th)/min·ft²", "Btu (th)/minute/square foot"),
                ("Btu(th)/h·ft²", "Btu (th)/hour/square foot"),
                ("CHU/h·ft²", "CHU/hour/square foot")
            ]
        case .heatTransverCoefficient:
            return [
                ("W/m²·K", "watt/square meter/K"),
                ("W/m²·°C", "watt/square meter/°C"),
                ("J/s·m²·K", "joule/second/square meter/K"),
                ("cal(IT)/s·cm²·°C", "calorie (IT)/second/square centimeter/°C"),
                ("kcal(IT)/h·m²·°C", "kilocalorie (IT)/hour/square meter/°C"),
                ("kcal(IT)/h·ft²·°C", "kilocalorie (IT)/hour/square foot/°C"),
                ("Btu(IT)/s·ft²·°F", "Btu (IT)/second/square foot/°F"),
                ("Btu(th)/s·ft²·°F", "Btu (th)/second/square foot/°F"),
                ("Btu(IT)/h·ft²·°F", "Btu (IT)/hour/square foot/°F"),
                ("Btu(th)/h·ft²·°F", "Btu (th)/hour/square foot/°F"),
                ("CHU/h·ft²·°C", "CHU/hour/square foot/°C")
            ]
        }
    }
}
