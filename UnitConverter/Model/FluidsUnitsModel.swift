//
//  FluidsUnitsModel.swift
//  UnitConverter
//
//  Created by Burak Albayrak on 3.09.2024.
//

import Foundation

enum FluidsUnitsCategory: String, CaseIterable, UnitCategory {
    case flow = "Flow"
    case flowMass = "Flow - Mass"
    case flowMolar = "Flow Molar"
    case massFluxDensity = "Mass Flux Density"
    case concentrationMolar = "Concentration - Molar"
    case concentrationSolution = "Concentration Solution"
    case viscosityDynamic = "Viscosity - Dynamic"
    case viscosityKinematic = "Viscosity - Kinematic"
    case surfaceTension = "Surface Tension"
    case permeability = "Permeability"

    
    var icon: String {
        switch self {
        case .concentrationMolar:
            return "circle.grid.cross"
        case .concentrationSolution:
            return "drop"
        case .flow:
            return "arrow.right.to.line"
        case .flowMass:
            return "scalemass"
        case .flowMolar:
            return "wave.3.forward"
        case .massFluxDensity:
            return "chart.bar"
        case .permeability:
            return "square.stack.3d.forward.dottedline"
        case .surfaceTension:
            return "drop.triangle"
        case .viscosityDynamic:
            return "waveform.path.ecg"
        case .viscosityKinematic:
            return "waveform.path.ecg.rectangle"
        }
    }
    
    var info: String {
        switch self {
        case .concentrationMolar:
            return """
                Concentration molar, or molarity, measures the concentration of a solute in a solution, expressed as the number of moles of solute per liter of solution. It is represented by the unit mol/L (M).
                
                For example, a solution with a molarity of 1 M means there is one mole of solute dissolved in one liter of solution.
                
                Molar concentration is a fundamental concept in chemistry, used to prepare solutions, conduct reactions, and determine the concentrations of reactants and products in chemical processes.
                
                Accurate calculation and measurement of molar concentration are crucial for precise chemical analysis, laboratory experiments, and industrial processes, ensuring the correct proportions and reactivity of chemical substances.
                """
        case .concentrationSolution:
            return """
                Concentration solution refers to the amount of solute present in a given volume of solvent or solution. It is typically expressed in terms such as molarity (moles per liter), molality (moles per kilogram of solvent), or mass percent (mass of solute per mass of solution).
                
                For instance, a solution with a concentration of 0.5 M indicates that there are 0.5 moles of solute dissolved in one liter of solution.
                
                Concentration is crucial in various fields, including chemistry, biology, and environmental science, as it affects the rate and extent of chemical reactions, biological processes, and pollutant levels.
                
                Accurate measurement and control of solution concentration are essential for preparing solutions with precise properties, conducting experiments, and ensuring the effectiveness of chemical and biological processes.
                """
        case .flow:
            return """
                Flow refers to the movement or transfer of a fluid (liquid or gas) through a medium or along a path, characterized by the rate at which it moves. It is commonly measured in terms of volume per unit time, such as liters per second (L/s) or cubic meters per hour (m³/h).
                
                For example, the flow rate of water through a pipe might be 10 L/s.
                
                Flow is a key concept in various fields including fluid dynamics, engineering, and environmental science.
                
                It influences the design and operation of systems such as pipelines, pumps, and ventilation systems.
                
                Understanding and controlling flow is essential for optimizing performance, ensuring safety, and managing resources effectively in applications ranging from industrial processes to natural water systems.
                """
        case .flowMass:
            return """
                Flow mass refers to the mass of a fluid passing through a given cross-sectional area per unit of time. It quantifies how much mass of a fluid is moving through a pipe or channel and is typically measured in kilograms per second (kg/s).
                
                For example, if a pipeline transports 5 kg of water per second, its flow mass is 5 kg/s.
                
                This measurement is crucial in various industries, including chemical processing, oil and gas, and water management, as it affects the efficiency and design of systems that handle fluids.
                
                Accurate determination of flow mass is essential for optimizing processes, controlling chemical reactions, and managing resources effectively.
                """
        case .flowMolar:
            return """
                Flow molar, or molar flow rate, measures the amount of substance (in moles) passing through a given cross-sectional area per unit time. It is typically expressed in units like moles per second (mol/s).
                
                For example, a molar flow rate of 2 mol/s indicates that two moles of a substance are flowing through the area each second.
                
                This measurement is essential in chemical engineering and process design, particularly in reactions and processes where the concentration of reactants and products is critical.
                
                Accurate determination of flow molar is crucial for optimizing chemical reactions, controlling production rates, and ensuring the efficient operation of processes involving gaseous or liquid reactants and products.
                """
        case .massFluxDensity:
            return """
                Mass flux density, or mass flow density, measures the amount of mass flowing through a unit area per unit time. It quantifies how much mass passes through a cross-sectional area in a given time frame and is typically expressed in units such as kilograms per square meter per second (kg/m²/s).
                
                For example, if a fluid has a mass flux density of 3 kg/m²/s, it means that 3 kilograms of mass are flowing through each square meter of cross-sectional area every second.
                
                This concept is important in various fields such as fluid dynamics, meteorology, and chemical engineering, where it helps in understanding and designing systems involving the movement of fluids or particulate matter.
                
                Accurate measurement of mass flux density is crucial for optimizing processes, controlling environmental impacts, and ensuring efficient operation in applications like pipeline design and atmospheric studies.
                """
        case .permeability:
            return """
                Permeability measures a material's ability to allow fluids (liquids or gases) to pass through it. It quantifies how easily a fluid can move through a porous medium, such as soil, rock, or filter material.
                
                The SI unit for permeability is the square meter (m²), but it is often expressed in darcys or millidarcys in geotechnical and petroleum engineering.
                
                For example, a rock with high permeability allows water to flow through it easily, while a material with low permeability, such as clay, restricts fluid flow. Permeability is crucial in fields like hydrogeology, civil engineering, and materials science, affecting groundwater flow, oil extraction, and the design of filtration systems.
                
                Accurate measurement of permeability is essential for understanding fluid dynamics, optimizing resource extraction, and managing environmental impacts.
                """
        case .surfaceTension:
            return """
                Surface tension is a physical phenomenon where the surface of a liquid behaves like a stretched elastic membrane. It is caused by the cohesive forces between liquid molecules at the surface, which create a tendency for the liquid to minimize its surface area. 
                
                The SI unit for surface tension is the newton per meter (N/m).
                
                For example, water has a relatively high surface tension, which allows it to form droplets and enables small objects, like a paperclip, to float on its surface if placed gently. 
                
                Surface tension is significant in various processes and applications, including the formation of bubbles, the behavior of liquids in capillary tubes, and the design of detergents and coatings.
                
                Understanding and measuring surface tension are crucial for optimizing chemical reactions, improving fluid handling, and enhancing material properties.
                """
        case .viscosityDynamic:
            return """
                Dynamic viscosity measures a fluid's resistance to shear or flow. It quantifies the internal friction between adjacent layers of a fluid as they move relative to each other.
                
                The SI unit for dynamic viscosity is the pascal-second (Pa·s), but it is also commonly expressed in poise (P), where 1 P = 0.1 Pa·s.
                
                For example, honey has a high dynamic viscosity compared to water, meaning it flows more slowly and resists deformation more.
                
                Dynamic viscosity is crucial in various applications such as fluid dynamics, engineering, and manufacturing, influencing how fluids are pumped, processed, and utilized.
                
                Accurate measurement of dynamic viscosity is essential for designing efficient systems, optimizing fluid handling, and ensuring product quality in industries like petrochemicals, food processing, and pharmaceuticals.
                """
        case .viscosityKinematic:
            return """
                Kinematic viscosity measures a fluid's resistance to flow under the influence of gravity. It represents the ratio of dynamic viscosity to the fluid's density and is expressed in square meters per second (m²/s) or centistokes (cSt), where 1 cSt = 1 × 10⁻⁶ m²/s.
                
                For example, motor oil with a kinematic viscosity of 10 cSt flows more easily than oil with a viscosity of 100 cSt.
                
                Kinematic viscosity is important in various applications, such as lubrication, hydraulic systems, and fluid dynamics, as it affects how fluids move and interact in different conditions.
                
                Accurate measurement of kinematic viscosity is essential for ensuring proper fluid performance, optimizing system efficiency, and maintaining the quality of products in industries like automotive, aerospace, and manufacturing.
                """
        }
    }
    
    var availableUnits: [Dimension] {
        switch self {
        case .concentrationMolar:
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
            
        case .concentrationSolution:
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
            
        case .flow:
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
            
        case .flowMass:
            return [UnitTemperature.celsius,
                    UnitTemperature.fahrenheit,
                    UnitTemperature.kelvin]
            
        case .flowMolar:
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
            
        case .massFluxDensity:
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
            
        case .permeability:
            return [
                UnitAngle.degrees,
                UnitAngle.arcMinutes,
                UnitAngle.arcSeconds,
                UnitAngle.radians,
                UnitAngle.gradians,
                UnitAngle.revolutions
            ]
            
        case .surfaceTension:
            return [
                UnitSpeed.metersPerSecond,
                UnitSpeed.kilometersPerHour,
                UnitSpeed.milesPerHour,
                UnitSpeed.knots
            ]
            
        case .viscosityDynamic:
            return [
                UnitDuration.hours,
                UnitDuration.minutes,
                UnitDuration.seconds,
                UnitDuration.milliseconds,
                UnitDuration.microseconds,
                UnitDuration.nanoseconds,
                UnitDuration.picoseconds
            ]
            
        case .viscosityKinematic:
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
        case .concentrationMolar:
            return ["Degrees", "Arc Minutes", "Arc Seconds", "Radians", "Gradians", "Revolutions"]
        case .concentrationSolution:
            return ["Degrees", "Arc Minutes", "Arc Seconds", "Radians", "Gradians", "Revolutions"]
        case .flow:
            return ["Degrees", "Arc Minutes", "Arc Seconds", "Radians", "Gradians", "Revolutions"]
        case .flowMass:
            return ["Degrees", "Arc Minutes", "Arc Seconds", "Radians", "Gradians", "Revolutions"]
        case .flowMolar:
            return ["Degrees", "Arc Minutes", "Arc Seconds", "Radians", "Gradians", "Revolutions"]
        case .massFluxDensity:
            return ["Degrees", "Arc Minutes", "Arc Seconds", "Radians", "Gradians", "Revolutions"]
        case .permeability:
            return ["Degrees", "Arc Minutes", "Arc Seconds", "Radians", "Gradians", "Revolutions"]
        case .surfaceTension:
            return ["Degrees", "Arc Minutes", "Arc Seconds", "Radians", "Gradians", "Revolutions"]
        case .viscosityDynamic:
            return ["Degrees", "Arc Minutes", "Arc Seconds", "Radians", "Gradians", "Revolutions"]
        case .viscosityKinematic:
            return ["Degrees", "Arc Minutes", "Arc Seconds", "Radians", "Gradians", "Revolutions"]
        }
    }
}
