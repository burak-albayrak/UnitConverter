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
    
    var availableUnits: [Dimension] {
        switch self {
        case .fuelEfficiencyMass:
            return [
                UnitArea.squareMegameters,
                UnitArea.squareKilometers,
                UnitArea.squareMeters,
                UnitArea.squareCentimeters,
                UnitArea.squareMillimeters,
                UnitArea.squareNanometers,
                UnitArea.squareInches,
                UnitArea.squareFeet,
                UnitArea.squareYards,
                UnitArea.squareMiles,
                UnitArea.acres,
                UnitArea.ares,
                UnitArea.hectares
            ]
            
        case .fuelEfficiencyVolume:
            return [
                UnitLength.megameters,
                UnitLength.kilometers,
                UnitLength.hectometers,
                UnitLength.decameters,
                UnitLength.meters,
                UnitLength.decimeters,
                UnitLength.centimeters,
                UnitLength.millimeters,
                UnitLength.micrometers,
                UnitLength.nanometers,
                UnitLength.picometers,
                UnitLength.inches,
                UnitLength.feet,
                UnitLength.yards,
                UnitLength.miles,
                UnitLength.scandinavianMiles,
                UnitLength.lightyears,
                UnitLength.nauticalMiles,
                UnitLength.fathoms,
                UnitLength.astronomicalUnits,
                UnitLength.parsecs
            ]
            
        case .heatDensity:
            return [
                UnitPressure.newtonsPerMetersSquared,
                UnitPressure.gigapascals,
                UnitPressure.megapascals,
                UnitPressure.kilopascals,
                UnitPressure.hectopascals,
                UnitPressure.inchesOfMercury,
                UnitPressure.bars,
                UnitPressure.millibars,
                UnitPressure.millimetersOfMercury,
                UnitPressure.poundsForcePerSquareInch
            ]
            
        case .heatFluxDensity:
            return [UnitTemperature.celsius,
                    UnitTemperature.fahrenheit,
                    UnitTemperature.kelvin]
            
        case .heatTransverCoefficient:
            return [
                UnitVolume.megaliters,
                UnitVolume.kiloliters,
                UnitVolume.liters,
                UnitVolume.deciliters,
                UnitVolume.centiliters,
                UnitVolume.milliliters,
                UnitVolume.cubicKilometers,
                UnitVolume.cubicMeters,
                UnitVolume.cubicDecimeters,
                UnitVolume.cubicCentimeters,
                UnitVolume.cubicMillimeters,
                UnitVolume.cubicInches,
                UnitVolume.cubicFeet,
                UnitVolume.cubicYards,
                UnitVolume.cubicMiles,
                UnitVolume.acreFeet,
                UnitVolume.bushels,
                UnitVolume.teaspoons,
                UnitVolume.tablespoons,
                UnitVolume.fluidOunces,
                UnitVolume.cups,
                UnitVolume.pints,
                UnitVolume.quarts,
                UnitVolume.gallons,
                UnitVolume.imperialTeaspoons,
                UnitVolume.imperialTablespoons,
                UnitVolume.imperialFluidOunces,
                UnitVolume.imperialPints,
                UnitVolume.imperialQuarts,
                UnitVolume.imperialGallons,
                UnitVolume.metricCups
            ]
            
        case .spesificHeatCapacity:
            return [
                UnitMass.kilograms,
                UnitMass.grams,
                UnitMass.decigrams,
                UnitMass.centigrams,
                UnitMass.milligrams,
                UnitMass.micrograms,
                UnitMass.nanograms,
                UnitMass.picograms,
                UnitMass.ounces,
                UnitMass.pounds,
                UnitMass.stones,
                UnitMass.metricTons,
                UnitMass.shortTons,
                UnitMass.carats,
                UnitMass.ouncesTroy,
                UnitMass.slugs
            ]
            
        case .temperatureInterval:
            return [
                UnitAngle.degrees,
                UnitAngle.arcMinutes,
                UnitAngle.arcSeconds,
                UnitAngle.radians,
                UnitAngle.gradians,
                UnitAngle.revolutions
            ]
            
        case .thermalConductivity:
            return [
                UnitSpeed.metersPerSecond,
                UnitSpeed.kilometersPerHour,
                UnitSpeed.milesPerHour,
                UnitSpeed.knots
            ]
            
        case .thermalExpansion:
            return [
                UnitDuration.hours,
                UnitDuration.minutes,
                UnitDuration.seconds,
                UnitDuration.milliseconds,
                UnitDuration.microseconds,
                UnitDuration.nanoseconds,
                UnitDuration.picoseconds
            ]
            
        case .thermalResistance:
            return [
                UnitDuration.hours,
                UnitDuration.minutes,
                UnitDuration.seconds,
                UnitDuration.milliseconds,
                UnitDuration.microseconds,
                UnitDuration.nanoseconds,
                UnitDuration.picoseconds
            ]
        }
    }
    
    var availableUnitNames: [String] {
        switch self {
        case .fuelEfficiencyMass:
            return ["Degrees", "Arc Minutes", "Arc Seconds", "Radians", "Gradians", "Revolutions"]
        case .fuelEfficiencyVolume:
            return ["Degrees", "Arc Minutes", "Arc Seconds", "Radians", "Gradians", "Revolutions"]
        case .heatDensity:
            return ["Degrees", "Arc Minutes", "Arc Seconds", "Radians", "Gradians", "Revolutions"]
        case .heatFluxDensity:
            return ["Degrees", "Arc Minutes", "Arc Seconds", "Radians", "Gradians", "Revolutions"]
        case .heatTransverCoefficient:
            return ["Degrees", "Arc Minutes", "Arc Seconds", "Radians", "Gradians", "Revolutions"]
        case .spesificHeatCapacity:
            return ["Degrees", "Arc Minutes", "Arc Seconds", "Radians", "Gradians", "Revolutions"]
        case .temperatureInterval:
            return ["Degrees", "Arc Minutes", "Arc Seconds", "Radians", "Gradians", "Revolutions"]
        case .thermalConductivity:
            return ["Degrees", "Arc Minutes", "Arc Seconds", "Radians", "Gradians", "Revolutions"]
        case .thermalExpansion:
            return ["Degrees", "Arc Minutes", "Arc Seconds", "Radians", "Gradians", "Revolutions"]
        case .thermalResistance:
            return ["Degrees", "Arc Minutes", "Arc Seconds", "Radians", "Gradians", "Revolutions"]
        }
    }
}
