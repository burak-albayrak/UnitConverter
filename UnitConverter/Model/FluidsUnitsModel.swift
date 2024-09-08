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

    func convert(_ value: Double, from fromUnit: String, to toUnit: String) -> Double {
        switch self {
        case .flow:
            return convertVolumetricFlowRate(value, from: fromUnit, to: toUnit)
        case .flowMass:
            return convertMassFlowRate(value, from: fromUnit, to: toUnit)
        case .flowMolar:
            return convertMolarFlowRate(value, from: fromUnit, to: toUnit)
        case .massFluxDensity:
            return convertMassFlowRateDensity(value, from: fromUnit, to: toUnit)
        case .concentrationMolar:
            return convertMolarConcentration(value, from: fromUnit, to: toUnit)
        case .concentrationSolution:
            return convertDensity(value, from: fromUnit, to: toUnit)
        case .viscosityDynamic:
            return convertDynamicViscosity(value, from: fromUnit, to: toUnit)
        case .viscosityKinematic:
            return convertKinematicViscosity(value, from: fromUnit, to: toUnit)
        case .surfaceTension:
            return convertSurfaceTension(value, from: fromUnit, to: toUnit)
        case .permeability:
            return convertPermeability(value, from: fromUnit, to: toUnit)

        }
    }
    
    private func convertVolumetricFlowRate(_ value: Double, from fromUnit: String, to toUnit: String) -> Double {
        let cubicMeterPerSecondValues: [String: Double] = [
            "cubic meter/second": 1,
            "cubic meter/day": 1.15741e-5,
            "cubic meter/hour": 0.0002777778,
            "cubic meter/minute": 0.0166666667,
            "cubic centimeter/day": 1.1574074074074e-11,
            "cubic centimeter/hour": 2.7777777777778e-10,
            "cubic centimeter/minute": 1.6666666666667e-8,
            "cubic centimeter/second": 1e-6,
            "liter/day": 1.1574074074074e-8,
            "liter/hour": 2.7777777777778e-7,
            "liter/minute": 1.66667e-5,
            "liter/second": 0.001,
            "milliliter/day": 1.1574074074074e-11,
            "milliliter/hour": 2.7777777777778e-10,
            "milliliter/minute": 1.6666666666667e-8,
            "milliliter/second": 1e-6,
            "gallon (US)/day": 4.3812636388889e-8,
            "gallon (US)/hour": 1.0515032733333e-6,
            "gallon (US)/minute": 6.30902e-5,
            "gallon (US)/second": 0.0037854118,
            "gallon (UK)/day": 5.2616782407407e-8,
            "gallon (UK)/hour": 1.2628027777778e-6,
            "gallon (UK)/minute": 7.57682e-5,
            "gallon (UK)/second": 0.00454609,
            "kilobarrel (US)/day": 0.0018401307,
            "barrel (US)/day": 1.8401307283333e-6,
            "barrel (US)/hour": 4.41631e-5,
            "barrel (US)/minute": 0.0026497882,
            "barrel (US)/second": 0.1589872949,
            "acre-foot/year": 3.91136e-5,
            "acre-foot/day": 0.0142764673,
            "acre-foot/hour": 0.3426352143,
            "hundred-cubic foot/day": 3.27741e-5,
            "hundred-cubic foot/hour": 0.0007865791,
            "hundred-cubic foot/minute": 0.0471947443,
            "ounce/hour": 8.2148693229167e-9,
            "ounce/minute": 4.92892159375e-7,
            "ounce/second": 2.95735e-5,
            "ounce (UK)/hour": 7.8925178504774e-9,
            "ounce (UK)/minute": 4.7355107102865e-7,
            "ounce (UK)/second": 2.84131e-5,
            "cubic yard/hour": 0.0002123763,
            "cubic yard/minute": 0.012742581,
            "cubic yard/second": 0.764554858,
            "cubic foot/hour": 7.86579072e-6,
            "cubic foot/minute": 0.0004719474,
            "cubic foot/second": 0.0283168466,
            "cubic inch/hour": 4.5519622224454e-9,
            "cubic inch/minute": 2.7311773333333e-7,
            "cubic inch/second": 1.63871e-5,
            "pound/second (Gasoline at 15.5°C)": 0.0006135189,
            "pound/minute (Gasoline at 15.5°C)": 1.02253e-5,
            "pound/hour (Gasoline at 15.5°C)": 1.704219244213e-7,
            "pound/day (Gasoline at 15.5°C)": 7.1009135150463e-9,
            "kilogram/second (Gasoline at 15.5°C)": 0.0013525777,
            "kilogram/minute (Gasoline at 15.5°C)": 2.2543e-5,
            "kilogram/hour (Gasoline at 15.5°C)": 3.7571602974537e-7,
            "kilogram/day (Gasoline at 15.5°C)": 1.5654834571759e-8
        ]

        guard let fromValue = cubicMeterPerSecondValues[fromUnit.lowercased()], let toValue = cubicMeterPerSecondValues[toUnit.lowercased()] else {
            return value // Eğer birim bulunamazsa, orijinal değeri döndür
        }

        let cubicMeterPerSecond = value * fromValue
        return cubicMeterPerSecond / toValue
    }
    
    private func convertMassFlowRate(_ value: Double, from fromUnit: String, to toUnit: String) -> Double {
        let kilogramPerSecondValues: [String: Double] = [
            "kilogram/second": 1,
            "gram/second": 0.001,
            "gram/minute": 1.66667e-5,
            "gram/hour": 2.7777777777778e-7,
            "gram/day": 1.1574074074074e-8,
            "milligram/minute": 1.6666666666667e-8,
            "milligram/hour": 2.7777777777778e-10,
            "milligram/day": 1.1574074074074e-11,
            "kilogram/minute": 0.0166666667,
            "kilogram/hour": 0.0002777778,
            "kilogram/day": 1.15741e-5,
            "exagram/second": 1e15,
            "petagram/second": 1000000000000,
            "teragram/second": 1000000000,
            "gigagram/second": 1000000,
            "megagram/second": 1000,
            "hectogram/second": 0.1,
            "dekagram/second": 0.01,
            "decigram/second": 0.0001,
            "centigram/second": 1e-5,
            "milligram/second": 1e-6,
            "microgram/second": 1e-9,
            "ton (metric)/second": 1000,
            "ton (metric)/minute": 16.6666666667,
            "ton (metric)/hour": 0.2777777778,
            "ton (metric)/day": 0.0115740741,
            "ton (short)/hour": 0.2519957611,
            "pound/second": 0.45359237,
            "pound/minute": 0.0075598728,
            "pound/hour": 0.0001259979,
            "pound/day": 5.2499116898148e-6
        ]
        
        guard let fromValue = kilogramPerSecondValues[fromUnit.lowercased()], let toValue = kilogramPerSecondValues[toUnit.lowercased()] else {
            return value // Eğer birim bulunamazsa, orijinal değeri döndür
        }

        let kilogramPerSecond = value * fromValue
        return kilogramPerSecond / toValue
    }
    
    private func convertMolarFlowRate(_ value: Double, from fromUnit: String, to toUnit: String) -> Double {
        let molPerSecondValues: [String: Double] = [
            "mol/second": 1,
            "examol/second": 1e18,
            "petamol/second": 1e15,
            "teramol/second": 1e12,
            "gigamol/second": 1e9,
            "megamol/second": 1e6,
            "kilomol/second": 1e3,
            "hectomol/second": 1e2,
            "dekamol/second": 1e1,
            "decimol/second": 1e-1,
            "centimol/second": 1e-2,
            "millimol/second": 1e-3,
            "micromol/second": 1e-6,
            "nanomol/second": 1e-9,
            "picomol/second": 1e-12,
            "femtomol/second": 1e-15,
            "attomol/second": 1e-18,
            "mol/minute": 0.0166666667,
            "mol/hour": 0.0002777778,
            "mol/day": 1.15741e-5,
            "millimol/minute": 1.66667e-5,
            "millimol/hour": 2.7777777777778e-7,
            "millimol/day": 1.1574074074074e-8,
            "kilomol/minute": 16.6666666667,
            "kilomol/hour": 0.2777777778,
            "kilomol/day": 0.0115740741
        ]

        guard let fromValue = molPerSecondValues[fromUnit.lowercased()], let toValue = molPerSecondValues[toUnit.lowercased()] else {
            return value // Eğer birim bulunamazsa, orijinal değeri döndür
        }

        let molPerSecond = value * fromValue
        return molPerSecond / toValue
    }
    
    private func convertMassFlowRateDensity(_ value: Double, from fromUnit: String, to toUnit: String) -> Double {
        let gramPerSecondPerSquareMeterValues: [String: Double] = [
            "gram/second/square meter": 1,
            "kilogram/hour/square meter": 0.2777777778,
            "kilogram/hour/square foot": 2.9899751173,
            "kilogram/second/square meter": 1000,
            "gram/second/sq. centimeter": 10000,
            "pound/hour/square foot": 1.3562299132,
            "pound/second/square foot": 4882.4276872752
        ]

        guard let fromValue = gramPerSecondPerSquareMeterValues[fromUnit.lowercased()], let toValue = gramPerSecondPerSquareMeterValues[toUnit.lowercased()] else {
            return value // Eğer birim bulunamazsa, orijinal değeri döndür
        }

        let gramPerSecondPerSquareMeter = value * fromValue
        return gramPerSecondPerSquareMeter / toValue
    }
    
    private func convertMolarConcentration(_ value: Double, from fromUnit: String, to toUnit: String) -> Double {
        let molPerCubicMeterValues: [String: Double] = [
            "mol/cubic meter": 1,
            "mol/liter": 1000,
            "mol/cubic centimeter": 1000000,
            "mol/cubic millimeter": 1000000000,
            "kilomol/cubic meter": 1000,
            "kilomol/liter": 1000000,
            "kilomol/cubic centimeter": 1000000000,
            "kilomol/cubic millimeter": 1000000000000,
            "millimol/cubic meter": 0.001,
            "millimol/liter": 1,
            "millimol/cubic centimeter": 1000,
            "millimol/cubic millimeter": 1000000
        ]

        guard let fromValue = molPerCubicMeterValues[fromUnit.lowercased()], let toValue = molPerCubicMeterValues[toUnit.lowercased()] else {
            return value // Eğer birim bulunamazsa, orijinal değeri döndür
        }

        let molPerCubicMeter = value * fromValue
        return molPerCubicMeter / toValue
    }
    
    private func convertDensity(_ value: Double, from fromUnit: String, to toUnit: String) -> Double {
        let kilogramPerLiterValues: [String: Double] = [
            "kilogram/liter": 1,
            "gram/liter": 0.001,
            "milligram/liter": 1e-6,
            "part/million (ppm)": 9.988590003673e-7,
            "grain/gallon (US)": 1.71181e-5,
            "grain/gallon (UK)": 1.42538e-5,
            "pound/gallon (US)": 0.1198264284,
            "pound/gallon (UK)": 0.0997763736,
            "pound/million gallon (US)": 1.1982642843713e-7,
            "pound/million gallon (UK)": 9.9776373608464e-8,
            "pound/cubic foot": 0.0160184635
        ]

        guard let fromValue = kilogramPerLiterValues[fromUnit.lowercased()], let toValue = kilogramPerLiterValues[toUnit.lowercased()] else {
            return value // Eğer birim bulunamazsa, orijinal değeri döndür
        }

        let kilogramPerLiter = value * fromValue
        return kilogramPerLiter / toValue
    }
    
    private func convertDynamicViscosity(_ value: Double, from fromUnit: String, to toUnit: String) -> Double {
        let pascalSecondValues: [String: Double] = [
            "pascal second": 1,
            "kilogram-force second/square meter": 9.80665,
            "newton second/square meter": 1,
            "millinewton second/sq. meter": 0.001,
            "dyne second/sq. centimeter": 0.1,
            "poise": 0.1,
            "exapoise": 1e17,
            "petapoise": 1e14,
            "terapoise": 1e11,
            "gigapoise": 1e8,
            "megapoise": 1e5,
            "kilopoise": 100,
            "hectopoise": 10,
            "dekapoise": 1,
            "decipoise": 0.01,
            "centipoise": 0.001,
            "millipoise": 1e-4,
            "micropoise": 1e-7,
            "nanopoise": 1e-10,
            "picopoise": 1e-13,
            "femtopoise": 1e-16,
            "attopoise": 1e-19,
            "pound-force second/sq. inch": 6894.7572931684,
            "pound-force second/sq. foot": 47.8802589802,
            "poundal second/square foot": 1.4881639436,
            "gram/centimeter/second": 0.1,
            "slug/foot/second": 47.8802589802,
            "pound/foot/second": 1.4881639436,
            "pound/foot/hour": 0.0004133789
        ]
        
        guard let fromValue = pascalSecondValues[fromUnit.lowercased()], let toValue = pascalSecondValues[toUnit.lowercased()] else {
            return value // Eğer birim bulunamazsa, orijinal değeri döndür
        }

        let pascalSecond = value * fromValue
        return pascalSecond / toValue
    }
    
    private func convertKinematicViscosity(_ value: Double, from fromUnit: String, to toUnit: String) -> Double {
        let squareMeterPerSecondValues: [String: Double] = [
            "square meter/second": 1,
            "square meter/hour": 0.0002777778,
            "square centimeter/second": 0.0001,
            "square millimeter/second": 1e-6,
            "square foot/second": 0.09290304,
            "square foot/hour": 2.58064e-5,
            "square inch/second": 0.00064516,
            "stokes": 0.0001,
            "exastokes": 1e14,
            "petastokes": 1e11,
            "terastokes": 1e8,
            "gigastokes": 1e5,
            "megastokes": 100,
            "kilostokes": 0.1,
            "hectostokes": 0.01,
            "dekastokes": 0.001,
            "decistokes": 1e-5,
            "centistokes": 1e-6,
            "millistokes": 1e-7,
            "microstokes": 1e-10,
            "nanostokes": 1e-13,
            "picostokes": 1e-16,
            "femtostokes": 1e-19,
            "attostokes": 1e-22
        ]

        guard let fromValue = squareMeterPerSecondValues[fromUnit.lowercased()], let toValue = squareMeterPerSecondValues[toUnit.lowercased()] else {
            return value // Eğer birim bulunamazsa, orijinal değeri döndür
        }

        let squareMeterPerSecond = value * fromValue
        return squareMeterPerSecond / toValue
    }
    
    private func convertSurfaceTension(_ value: Double, from fromUnit: String, to toUnit: String) -> Double {
        let newtonPerMeterValues: [String: Double] = [
            "newton/meter": 1,
            "millinewton/meter": 0.001,
            "gram-force/centimeter": 0.980665,
            "dyne/centimeter": 0.001,
            "erg/square centimeter": 0.001,
            "erg/square millimeter": 0.1,
            "poundal/inch": 5.443108491,
            "pound-force/inch": 175.1268369864
        ]

        guard let fromValue = newtonPerMeterValues[fromUnit.lowercased()], let toValue = newtonPerMeterValues[toUnit.lowercased()] else {
            return value // Eğer birim bulunamazsa, orijinal değeri döndür
        }

        let newtonPerMeter = value * fromValue
        return newtonPerMeter / toValue
    }
    
    private func convertPermeability(_ value: Double, from fromUnit: String, to toUnit: String) -> Double {
        let kgPerPascalSecondSquareMeterValues: [String: Double] = [
            "kilogram/pascal/second/square meter": 1,
            "permeability (0°C)": 5.72135e-11,
            "permeability (23°C)": 5.74525e-11,
            "permeability inches (0°C)": 1.45322e-12,
            "permeability inches (23°C)": 1.45929e-12
        ]

        guard let fromValue = kgPerPascalSecondSquareMeterValues[fromUnit.lowercased()], let toValue = kgPerPascalSecondSquareMeterValues[toUnit.lowercased()] else {
            return value // Eğer birim bulunamazsa, orijinal değeri döndür
        }

        let kgPerPascalSecondSquareMeter = value * fromValue
        return kgPerPascalSecondSquareMeter / toValue
    }
    
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
        
    var availableUnits: [(symbol: String, name: String)] {
        switch self {
        case .flow:
            return [
                ("m³/s", "cubic meter/second"),
                ("m³/d", "cubic meter/day"),
                ("m³/h", "cubic meter/hour"),
                ("m³/min", "cubic meter/minute"),
                ("cm³/d", "cubic centimeter/day"),
                ("cm³/h", "cubic centimeter/hour"),
                ("cm³/min", "cubic centimeter/minute"),
                ("cm³/s", "cubic centimeter/second"),
                ("L/d", "liter/day"),
                ("L/h", "liter/hour"),
                ("L/min", "liter/minute"),
                ("L/s", "liter/second"),
                ("mL/d", "milliliter/day"),
                ("mL/h", "milliliter/hour"),
                ("mL/min", "milliliter/minute"),
                ("mL/s", "milliliter/second"),
                ("gal(US)/d", "gallon (US)/day"),
                ("gal(US)/h", "gallon (US)/hour"),
                ("gal(US)/min", "gallon (US)/minute"),
                ("gal(US)/s", "gallon (US)/second"),
                ("gal(UK)/d", "gallon (UK)/day"),
                ("gal(UK)/h", "gallon (UK)/hour"),
                ("gal(UK)/min", "gallon (UK)/minute"),
                ("gal(UK)/s", "gallon (UK)/second"),
                ("kbbl(US)/d", "kilobarrel (US)/day"),
                ("bbl(US)/d", "barrel (US)/day"),
                ("bbl(US)/h", "barrel (US)/hour"),
                ("bbl(US)/min", "barrel (US)/minute"),
                ("bbl(US)/s", "barrel (US)/second"),
                ("ac·ft/y", "acre-foot/year"),
                ("ac·ft/d", "acre-foot/day"),
                ("ac·ft/h", "acre-foot/hour"),
                ("hcf/d", "hundred-cubic foot/day"),
                ("hcf/h", "hundred-cubic foot/hour"),
                ("hcf/min", "hundred-cubic foot/minute"),
                ("oz/h", "ounce/hour"),
                ("oz/min", "ounce/minute"),
                ("oz/s", "ounce/second"),
                ("oz(UK)/h", "ounce (UK)/hour"),
                ("oz(UK)/min", "ounce (UK)/minute"),
                ("oz(UK)/s", "ounce (UK)/second"),
                ("yd³/h", "cubic yard/hour"),
                ("yd³/min", "cubic yard/minute"),
                ("yd³/s", "cubic yard/second"),
                ("ft³/h", "cubic foot/hour"),
                ("ft³/min", "cubic foot/minute"),
                ("ft³/s", "cubic foot/second"),
                ("in³/h", "cubic inch/hour"),
                ("in³/min", "cubic inch/minute"),
                ("in³/s", "cubic inch/second"),
                ("lb/s (Gas)", "pound/second (Gasoline at 15.5°C)"),
                ("lb/min (Gas)", "pound/minute (Gasoline at 15.5°C)"),
                ("lb/h (Gas)", "pound/hour (Gasoline at 15.5°C)"),
                ("lb/d (Gas)", "pound/day (Gasoline at 15.5°C)"),
                ("kg/s (Gas)", "kilogram/second (Gasoline at 15.5°C)"),
                ("kg/min (Gas)", "kilogram/minute (Gasoline at 15.5°C)"),
                ("kg/h (Gas)", "kilogram/hour (Gasoline at 15.5°C)"),
                ("kg/d (Gas)", "kilogram/day (Gasoline at 15.5°C)")
            ]
        case .flowMass:
            return [
                ("kg/s", "kilogram/second"),
                ("g/s", "gram/second"),
                ("g/min", "gram/minute"),
                ("g/h", "gram/hour"),
                ("g/d", "gram/day"),
                ("mg/min", "milligram/minute"),
                ("mg/h", "milligram/hour"),
                ("mg/d", "milligram/day"),
                ("kg/min", "kilogram/minute"),
                ("kg/h", "kilogram/hour"),
                ("kg/d", "kilogram/day"),
                ("Eg/s", "exagram/second"),
                ("Pg/s", "petagram/second"),
                ("Tg/s", "teragram/second"),
                ("Gg/s", "gigagram/second"),
                ("Mg/s", "megagram/second"),
                ("hg/s", "hectogram/second"),
                ("dag/s", "dekagram/second"),
                ("dg/s", "decigram/second"),
                ("cg/s", "centigram/second"),
                ("mg/s", "milligram/second"),
                ("µg/s", "microgram/second"),
                ("t/s", "ton (metric)/second"),
                ("t/min", "ton (metric)/minute"),
                ("t/h", "ton (metric)/hour"),
                ("t/d", "ton (metric)/day"),
                ("ton(short)/h", "ton (short)/hour"),
                ("lb/s", "pound/second"),
                ("lb/min", "pound/minute"),
                ("lb/h", "pound/hour"),
                ("lb/d", "pound/day")
            ]
        case .flowMolar:
            return [
                ("mol/s", "mol/second"),
                ("Emol/s", "examol/second"),
                ("Pmol/s", "petamol/second"),
                ("Tmol/s", "teramol/second"),
                ("Gmol/s", "gigamol/second"),
                ("Mmol/s", "megamol/second"),
                ("kmol/s", "kilomol/second"),
                ("hmol/s", "hectomol/second"),
                ("damol/s", "dekamol/second"),
                ("dmol/s", "decimol/second"),
                ("cmol/s", "centimol/second"),
                ("mmol/s", "millimol/second"),
                ("µmol/s", "micromol/second"),
                ("nmol/s", "nanomol/second"),
                ("pmol/s", "picomol/second"),
                ("fmol/s", "femtomol/second"),
                ("amol/s", "attomol/second"),
                ("mol/min", "mol/minute"),
                ("mol/h", "mol/hour"),
                ("mol/d", "mol/day"),
                ("mmol/min", "millimol/minute"),
                ("mmol/h", "millimol/hour"),
                ("mmol/d", "millimol/day"),
                ("kmol/min", "kilomol/minute"),
                ("kmol/h", "kilomol/hour"),
                ("kmol/d", "kilomol/day")
            ]
        case .massFluxDensity:
            return [
                ("g/s/m²", "gram/second/square meter"),
                ("kg/h/m²", "kilogram/hour/square meter"),
                ("kg/h/ft²", "kilogram/hour/square foot"),
                ("kg/s/m²", "kilogram/second/square meter"),
                ("g/s/cm²", "gram/second/sq. centimeter"),
                ("lb/h/ft²", "pound/hour/square foot"),
                ("lb/s/ft²", "pound/second/square foot")
            ]
        case .concentrationMolar:
            return [
                ("mol/m³", "mol/cubic meter"),
                ("mol/L", "mol/liter"),
                ("mol/cm³", "mol/cubic centimeter"),
                ("mol/mm³", "mol/cubic millimeter"),
                ("kmol/m³", "kilomol/cubic meter"),
                ("kmol/L", "kilomol/liter"),
                ("kmol/cm³", "kilomol/cubic centimeter"),
                ("kmol/mm³", "kilomol/cubic millimeter"),
                ("mmol/m³", "millimol/cubic meter"),
                ("mmol/L", "millimol/liter"),
                ("mmol/cm³", "millimol/cubic centimeter"),
                ("mmol/mm³", "millimol/cubic millimeter")
            ]
        case .concentrationSolution:
            return [
                ("kg/L", "kilogram/liter"),
                ("g/L", "gram/liter"),
                ("mg/L", "milligram/liter"),
                ("ppm", "part/million (ppm)"),
                ("gr/gal(US)", "grain/gallon (US)"),
                ("gr/gal(UK)", "grain/gallon (UK)"),
                ("lb/gal(US)", "pound/gallon (US)"),
                ("lb/gal(UK)", "pound/gallon (UK)"),
                ("lb/Mgal(US)", "pound/million gallon (US)"),
                ("lb/Mgal(UK)", "pound/million gallon (UK)"),
                ("lb/ft³", "pound/cubic foot")
            ]
        case .viscosityDynamic:
            return [
                ("Pa·s", "pascal second"),
                ("kgf·s/m²", "kilogram-force second/square meter"),
                ("N·s/m²", "newton second/square meter"),
                ("mN·s/m²", "millinewton second/sq. meter"),
                ("dyn·s/cm²", "dyne second/sq. centimeter"),
                ("P", "poise"),
                ("EP", "exapoise"),
                ("PP", "petapoise"),
                ("TP", "terapoise"),
                ("GP", "gigapoise"),
                ("MP", "megapoise"),
                ("kP", "kilopoise"),
                ("hP", "hectopoise"),
                ("daP", "dekapoise"),
                ("dP", "decipoise"),
                ("cP", "centipoise"),
                ("mP", "millipoise"),
                ("µP", "micropoise"),
                ("nP", "nanopoise"),
                ("pP", "picopoise"),
                ("fP", "femtopoise"),
                ("aP", "attopoise"),
                ("lbf·s/in²", "pound-force second/sq. inch"),
                ("lbf·s/ft²", "pound-force second/sq. foot"),
                ("pdl·s/ft²", "poundal second/square foot"),
                ("g/cm/s", "gram/centimeter/second"),
                ("slug/ft/s", "slug/foot/second"),
                ("lb/ft/s", "pound/foot/second"),
                ("lb/ft/h", "pound/foot/hour")
            ]
        case .viscosityKinematic:
            return [
                ("m²/s", "square meter/second"),
                ("m²/h", "square meter/hour"),
                ("cm²/s", "square centimeter/second"),
                ("mm²/s", "square millimeter/second"),
                ("ft²/s", "square foot/second"),
                ("ft²/h", "square foot/hour"),
                ("in²/s", "square inch/second"),
                ("St", "stokes"),
                ("ESt", "exastokes"),
                ("PSt", "petastokes"),
                ("TSt", "terastokes"),
                ("GSt", "gigastokes"),
                ("MSt", "megastokes"),
                ("kSt", "kilostokes"),
                ("hSt", "hectostokes"),
                ("daSt", "dekastokes"),
                ("dSt", "decistokes"),
                ("cSt", "centistokes"),
                ("mSt", "millistokes"),
                ("µSt", "microstokes"),
                ("nSt", "nanostokes"),
                ("pSt", "picostokes"),
                ("fSt", "femtostokes"),
                ("aSt", "attostokes")
            ]
        case .surfaceTension:
            return [
                ("N/m", "newton/meter"),
                ("mN/m", "millinewton/meter"),
                ("gf/cm", "gram-force/centimeter"),
                ("dyn/cm", "dyne/centimeter"),
                ("erg/cm²", "erg/square centimeter"),
                ("erg/mm²", "erg/square millimeter"),
                ("pdl/in", "poundal/inch"),
                ("lbf/in", "pound-force/inch")
            ]
        case .permeability:
            return [
                ("kg/Pa·s·m²", "kilogram/pascal/second/square meter"),
                ("perm(0°C)", "permeability (0°C)"),
                ("perm(23°C)", "permeability (23°C)"),
                ("perm·in(0°C)", "permeability inches (0°C)"),
                ("perm·in(23°C)", "permeability inches (23°C)")
            ]
        }
    }
}
