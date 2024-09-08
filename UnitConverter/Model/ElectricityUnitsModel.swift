//
//  ElectricityUnitsModel.swift
//  UnitConverter
//
//  Created by Burak Albayrak on 3.09.2024.
//

import Foundation

enum ElectricityUnitsCategory: String, CaseIterable, UnitCategory {
    case charge = "Charge"
    case linearChargeDensity = "Linear Charge Density"
    case surfaceChargeDensity = "Surface Charge Density"
    case volumeChargeDensity = "Volume Charge Density"
    case current = "Current"
    case linearCurrentDensity = "Linear Current Density"
    case surfaceCurrentDensity = "Surface Current Density"
    case electricFieldStrength = "Electric Field Strength"
    case electricPotential = "Electric Potential"
    case electricResistance = "Electric Resistance"
    case electricResistivity = "Electric Resistivity"
    case electricConductance = "Electric Conductance"
    case electricConductivity = "Electric Conductivity"
    case electrostaticCapacitance = "Electrostatic Capacitance"
    case inductance = "Inductance"
    
    func convert(_ value: Double, from fromUnit: String, to toUnit: String) -> Double {
        switch self {
        case .charge:
            return convertElectricCharge(value, from: fromUnit, to: toUnit)
        case .linearChargeDensity:
            return convertElectricChargeDensity(value, from: fromUnit, to: toUnit)
        case .surfaceChargeDensity:
            return convertSurfaceElectricChargeDensity(value, from: fromUnit, to: toUnit)
        case .volumeChargeDensity:
            return convertVolumetricElectricChargeDensity(value, from: fromUnit, to: toUnit)
        case .current:
            return convertElectricCurrent(value, from: fromUnit, to: toUnit)
        case .linearCurrentDensity:
            return convertMagneticFieldIntensity(value, from: fromUnit, to: toUnit)
        case .surfaceCurrentDensity:
            return convertElectricCurrentDensity(value, from: fromUnit, to: toUnit)
        case .electricFieldStrength:
            return convertElectricFieldStrength(value, from: fromUnit, to: toUnit)
        case .electricPotential:
            return convertElectricPotential(value, from: fromUnit, to: toUnit)
        case .electricResistance:
            return convertElectricResistance(value, from: fromUnit, to: toUnit)
        case .electricResistivity:
            return convertElectricResistivity(value, from: fromUnit, to: toUnit)
        case .electricConductance:
            return convertElectricConductance(value, from: fromUnit, to: toUnit)
        case .electricConductivity:
            return convertElectricConductivity(value, from: fromUnit, to: toUnit)
        case .electrostaticCapacitance:
            return convertElectricCapacitance(value, from: fromUnit, to: toUnit)
        case .inductance:
            return convertElectricInductance(value, from: fromUnit, to: toUnit)
        }
    }
    
    private func convertElectricCharge(_ value: Double, from fromUnit: String, to toUnit: String) -> Double {
        let coulombValues: [String: Double] = [
            "coulomb": 1,
            "megacoulomb": 1e6,
            "kilocoulomb": 1e3,
            "millicoulomb": 1e-3,
            "microcoulomb": 1e-6,
            "nanocoulomb": 1e-9,
            "picocoulomb": 1e-12,
            "abcoulomb": 10,
            "EMU of charge": 10,
            "statcoulomb": 3.335640951982e-10,
            "ESU of charge": 3.335640951982e-10,
            "franklin": 3.335640951982e-10,
            "ampere-hour": 3600,
            "ampere-minute": 60,
            "ampere-second": 1,
            "faraday (based on carbon 12)": 96485.309000004,
            "Elementary charge": 1.60217733e-19
        ]

        guard let fromValue = coulombValues[fromUnit.lowercased()], let toValue = coulombValues[toUnit.lowercased()] else {
            return value // Eğer birim bulunamazsa, orijinal değeri döndür
        }

        let coulombs = value * fromValue
        return coulombs / toValue
    }
    
    private func convertElectricChargeDensity(_ value: Double, from fromUnit: String, to toUnit: String) -> Double {
        let coulombPerMeterValues: [String: Double] = [
            "coulomb/meter": 1,
            "coulomb/centimeter": 100,
            "coulomb/inch": 39.3700787402,
            "abcoulomb/meter": 10,
            "abcoulomb/centimeter": 1000,
            "abcoulomb/inch": 393.7007874016
        ]

        guard let fromValue = coulombPerMeterValues[fromUnit.lowercased()], let toValue = coulombPerMeterValues[toUnit.lowercased()] else {
            return value // Eğer birim bulunamazsa, orijinal değeri döndür
        }

        let coulombsPerMeter = value * fromValue
        return coulombsPerMeter / toValue
    }
    
    private func convertSurfaceElectricChargeDensity(_ value: Double, from fromUnit: String, to toUnit: String) -> Double {
        let coulombPerSquareMeterValues: [String: Double] = [
            "coulomb/square meter": 1,
            "coulomb/square centimeter": 10000,
            "coulomb/square inch": 1550.0031000062,
            "abcoulomb/square meter": 10,
            "abcoulomb/square centimeter": 100000,
            "abcoulomb/square inch": 15500.031000062
        ]

        guard let fromValue = coulombPerSquareMeterValues[fromUnit.lowercased()], let toValue = coulombPerSquareMeterValues[toUnit.lowercased()] else {
            return value // Eğer birim bulunamazsa, orijinal değeri döndür
        }

        let coulombsPerSquareMeter = value * fromValue
        return coulombsPerSquareMeter / toValue
    }
    
    private func convertVolumetricElectricChargeDensity(_ value: Double, from fromUnit: String, to toUnit: String) -> Double {
        let coulombPerCubicMeterValues: [String: Double] = [
            "coulomb/cubic meter": 1,
            "coulomb/cubic centimeter": 1e6,
            "coulomb/cubic inch": 61023.744094732,
            "abcoulomb/cubic meter": 10,
            "abcoulomb/cubic centimeter": 1e7,
            "abcoulomb/cubic inch": 610237.44094732
        ]

        guard let fromValue = coulombPerCubicMeterValues[fromUnit.lowercased()], let toValue = coulombPerCubicMeterValues[toUnit.lowercased()] else {
            return value // Eğer birim bulunamazsa, orijinal değeri döndür
        }

        let coulombsPerCubicMeter = value * fromValue
        return coulombsPerCubicMeter / toValue
    }
    
    private func convertElectricCurrent(_ value: Double, from fromUnit: String, to toUnit: String) -> Double {
        let ampereValues: [String: Double] = [
            "ampere": 1,
            "kiloampere": 1e3,
            "milliampere": 1e-3,
            "biot": 10,
            "abampere": 10,
            "EMU of current": 10,
            "statampere": 3.335641e-10,
            "ESU of current": 3.335641e-10,
            "CGS e.m. unit": 10,
            "CGS e.s. unit": 3.335641e-10
        ]

        guard let fromValue = ampereValues[fromUnit.lowercased()], let toValue = ampereValues[toUnit.lowercased()] else {
            return value // Eğer birim bulunamazsa, orijinal değeri döndür
        }

        let amperes = value * fromValue
        return amperes / toValue
    }
    
    private func convertMagneticFieldIntensity(_ value: Double, from fromUnit: String, to toUnit: String) -> Double {
        let amperePerMeterValues: [String: Double] = [
            "ampere/meter": 1,
            "ampere/centimeter": 100,
            "ampere/inch": 39.3700787402,
            "abampere/meter": 10,
            "abampere/centimeter": 1000,
            "abampere/inch": 393.7007874016,
            "oersted": 79.5774715102,
            "gilbert/centimeter": 79.5774715102
        ]

        guard let fromValue = amperePerMeterValues[fromUnit.lowercased()], let toValue = amperePerMeterValues[toUnit.lowercased()] else {
            return value // Eğer birim bulunamazsa, orijinal değeri döndür
        }

        let amperesPerMeter = value * fromValue
        return amperesPerMeter / toValue
    }
    
    private func convertElectricCurrentDensity(_ value: Double, from fromUnit: String, to toUnit: String) -> Double {
        let amperePerSquareMeterValues: [String: Double] = [
            "ampere/square meter": 1,
            "ampere/square centimeter": 10000,
            "ampere/square inch": 1550.0031000062,
            "ampere/square mil": 1550003100.0062,
            "ampere/circular mil": 1973525240.9908,
            "abampere/square centimeter": 100000
        ]

        guard let fromValue = amperePerSquareMeterValues[fromUnit.lowercased()], let toValue = amperePerSquareMeterValues[toUnit.lowercased()] else {
            return value // Eğer birim bulunamazsa, orijinal değeri döndür
        }

        let amperesPerSquareMeter = value * fromValue
        return amperesPerSquareMeter / toValue
    }
    
    private func convertElectricFieldStrength(_ value: Double, from fromUnit: String, to toUnit: String) -> Double {
        let voltPerMeterValues: [String: Double] = [
            "volt/meter": 1,
            "kilovolt/meter": 1000,
            "kilovolt/centimeter": 100000,
            "volt/centimeter": 100,
            "millivolt/meter": 0.001,
            "microvolt/meter": 1e-6,
            "kilovolt/inch": 39370.078740157,
            "volt/inch": 39.3700787402,
            "volt/mil": 39370.078740157,
            "abvolt/centimeter": 1e-6,
            "statvolt/centimeter": 29979.19999934,
            "statvolt/inch": 11802.834645298,
            "newton/coulomb": 1
        ]

        guard let fromValue = voltPerMeterValues[fromUnit.lowercased()], let toValue = voltPerMeterValues[toUnit.lowercased()] else {
            return value // Eğer birim bulunamazsa, orijinal değeri döndür
        }

        let voltsPerMeter = value * fromValue
        return voltsPerMeter / toValue
    }
    
    private func convertElectricPotential(_ value: Double, from fromUnit: String, to toUnit: String) -> Double {
        let voltValues: [String: Double] = [
            "volt": 1,
            "watt/ampere": 1,
            "abvolt": 1e-8,
            "EMU of electric potential": 1e-8,
            "statvolt": 299.7925,
            "ESU of electric potential": 299.7925
        ]

        guard let fromValue = voltValues[fromUnit.lowercased()], let toValue = voltValues[toUnit.lowercased()] else {
            return value // Eğer birim bulunamazsa, orijinal değeri döndür
        }

        let volts = value * fromValue
        return volts / toValue
    }
    
    private func convertElectricResistance(_ value: Double, from fromUnit: String, to toUnit: String) -> Double {
        let ohmValues: [String: Double] = [
            "ohm": 1,
            "megohm": 1e6,
            "microhm": 1e-6,
            "volt/ampere": 1,
            "reciprocal siemens": 1,
            "abohm": 1e-9,
            "EMU of resistance": 1e-9,
            "statohm": 898755200000,
            "ESU of resistance": 898755200000,
            "Quantized Hall resistance": 25812.8056
        ]

        guard let fromValue = ohmValues[fromUnit.lowercased()], let toValue = ohmValues[toUnit.lowercased()] else {
            return value // Eğer birim bulunamazsa, orijinal değeri döndür
        }

        let ohms = value * fromValue
        return ohms / toValue
    }
    
    private func convertElectricResistivity(_ value: Double, from fromUnit: String, to toUnit: String) -> Double {
        let ohmMeterValues: [String: Double] = [
            "ohm meter": 1,
            "ohm centimeter": 0.01,
            "ohm inch": 0.0254,
            "microhm centimeter": 1e-8,
            "microhm inch": 2.5400000000102e-8,
            "abohm centimeter": 1e-11,
            "statohm centimeter": 8987524324.0156,
            "circular mil ohm/foot": 1.6624261130101e-9
        ]

        guard let fromValue = ohmMeterValues[fromUnit.lowercased()], let toValue = ohmMeterValues[toUnit.lowercased()] else {
            return value // Eğer birim bulunamazsa, orijinal değeri döndür
        }

        let ohmMeters = value * fromValue
        return ohmMeters / toValue
    }
    
    private func convertElectricConductance(_ value: Double, from fromUnit: String, to toUnit: String) -> Double {
        let siemensValues: [String: Double] = [
            "siemens": 1,
            "megasiemens": 1e6,
            "kilosiemens": 1e3,
            "millisiemens": 1e-3,
            "microsiemens": 1e-6,
            "ampere/volt": 1,
            "mho": 1,
            "gemmho": 1e-6,
            "micromho": 1e-6,
            "abmho": 1e9,
            "statmho": 1.1123470522803e-12,
            "Quantized Hall conductance": 3.87405e-5
        ]

        guard let fromValue = siemensValues[fromUnit.lowercased()], let toValue = siemensValues[toUnit.lowercased()] else {
            return value // Eğer birim bulunamazsa, orijinal değeri döndür
        }

        let siemens = value * fromValue
        return siemens / toValue
    }
    
    private func convertElectricConductivity(_ value: Double, from fromUnit: String, to toUnit: String) -> Double {
        let siemensPerMeterValues: [String: Double] = [
            "siemens/meter": 1,
            "picosiemens/meter": 1e-12,
            "mho/meter": 1,
            "mho/centimeter": 100,
            "abmho/meter": 1e9,
            "abmho/centimeter": 1e11,
            "statmho/meter": 1.1126534560019e-12,
            "statmho/centimeter": 1.1126534560019e-10
        ]

        guard let fromValue = siemensPerMeterValues[fromUnit.lowercased()], let toValue = siemensPerMeterValues[toUnit.lowercased()] else {
            return value // Eğer birim bulunamazsa, orijinal değeri döndür
        }

        let siemensPerMeter = value * fromValue
        return siemensPerMeter / toValue
    }
    
    private func convertElectricCapacitance(_ value: Double, from fromUnit: String, to toUnit: String) -> Double {
        let faradValues: [String: Double] = [
            "farad": 1,
            "exafarad": 1e18,
            "petafarad": 1e15,
            "terafarad": 1e12,
            "gigafarad": 1e9,
            "megafarad": 1e6,
            "kilofarad": 1e3,
            "hectofarad": 1e2,
            "dekafarad": 1e1,
            "decifarad": 1e-1,
            "centifarad": 1e-2,
            "millifarad": 1e-3,
            "microfarad": 1e-6,
            "nanofarad": 1e-9,
            "picofarad": 1e-12,
            "femtofarad": 1e-15,
            "attofarad": 1e-18,
            "coulomb/volt": 1,
            "abfarad": 1e9,
            "EMU of capacitance": 1e9,
            "statfarad": 1.112650056054e-12,
            "ESU of capacitance": 1.112650056054e-12
        ]

        guard let fromValue = faradValues[fromUnit.lowercased()], let toValue = faradValues[toUnit.lowercased()] else {
            return value // Eğer birim bulunamazsa, orijinal değeri döndür
        }

        let farads = value * fromValue
        return farads / toValue
    }
    
    private func convertElectricInductance(_ value: Double, from fromUnit: String, to toUnit: String) -> Double {
        let henryValues: [String: Double] = [
            "henry": 1,
            "exahenry": 1e18,
            "petahenry": 1e15,
            "terahenry": 1e12,
            "gigahenry": 1e9,
            "megahenry": 1e6,
            "kilohenry": 1e3,
            "hectohenry": 1e2,
            "dekahenry": 1e1,
            "decihenry": 1e-1,
            "centihenry": 1e-2,
            "millihenry": 1e-3,
            "microhenry": 1e-6,
            "nanohenry": 1e-9,
            "picohenry": 1e-12,
            "femtohenry": 1e-15,
            "attohenry": 1e-18,
            "weber/ampere": 1,
            "abhenry": 1e-9,
            "EMU of inductance": 1e-9,
            "stathenry": 898755200000,
            "ESU of inductance": 898755200000
        ]

        guard let fromValue = henryValues[fromUnit.lowercased()], let toValue = henryValues[toUnit.lowercased()] else {
            return value // Eğer birim bulunamazsa, orijinal değeri döndür
        }

        let henries = value * fromValue
        return henries / toValue
    }
    
    var icon: String {
        switch self {
        case .charge:
            return "bolt.circle"
        case .current:
            return "wave.3.forward"
        case .electricConductance:
            return "dot.radiowaves.right"
        case .electricConductivity:
            return "antenna.radiowaves.left.and.right"
        case .electricFieldStrength:
            return "waveform.path.ecg"
        case .electricPotential:
            return "bolt"
        case .electricResistance:
            return "bolt.horizontal"
        case .electricResistivity:
            return "waveform.path.badge.minus"
        case .electrostaticCapacitance:
            return "capsule.portrait"
        case .inductance:
            return "waveform.path.badge.plus"
        case .linearChargeDensity:
            return "ruler"
        case .linearCurrentDensity:
            return "cable.connector.horizontal"
        case .surfaceChargeDensity:
            return "rectangle.grid.2x2"
        case .surfaceCurrentDensity:
            return "rectangle.grid.3x2"
        case .volumeChargeDensity:
            return "cube.box"
        }
    }
    
    var info: String {
        switch self {
        case .charge:
            return """
                Electric charge is a fundamental property of matter that causes it to experience a force when placed in an electric or magnetic field. It comes in two types: positive and negative, with like charges repelling and opposite charges attracting each other.
                
                The SI unit for electric charge is the coulomb (C), where one coulomb is equivalent to the charge of approximately 6.242 × 10¹⁸ elementary charges (such as electrons).
                
                Charge is a crucial concept in understanding electrical phenomena and is fundamental to the operation of electronic devices, batteries, and circuits. 
                
                For example, the flow of electric charge through a conductor constitutes an electric current.
                
                Precise measurement and control of electric charge are vital in applications ranging from simple electronic circuits to advanced technology in telecommunications, computing, and energy systems.
                """
        case .current:
            return """
                Electric current is the flow of electric charge through a conductor, typically measured in amperes (A). It represents the rate at which charge passes through a point in a circuit.
                
                The SI unit for current, the ampere, is defined as one coulomb of charge passing through a point in a circuit per second. 
                
                Current can be either direct (DC), where the charge flows in one direction, or alternating (AC), where the charge periodically reverses direction.
                
                Electric current is a fundamental concept in electrical and electronic engineering, playing a crucial role in powering devices, transmitting signals, and performing work in systems ranging from household appliances to industrial machinery.
                
                Accurate measurement and control of current are essential for the safe and efficient operation of electrical systems and for the design of everything from simple circuits to complex electronic devices.
                """
        case .electricConductance:
            return """
                Electric conductance measures a material's ability to conduct electric current, indicating how easily charge flows through it.
                
                The SI unit for electric conductance is the siemens (S), where one siemens is the reciprocal of one ohm (Ω⁻¹). High conductance means low resistance to the flow of electric current, making the material an efficient conductor. 
                
                For example, metals like copper and aluminum have high conductance, making them ideal for electrical wiring.
                
                Electric conductance is crucial in designing circuits, determining the efficiency of electrical components, and ensuring that systems operate effectively with minimal energy loss.
                
                Accurate measurement of conductance is essential for optimizing performance in everything from simple electronic devices to complex power distribution networks.
                """
        case .electricConductivity:
            return """
                Electric conductivity measures a material's ability to conduct electric current, reflecting how easily electrons can move through the material. It is the inverse of electrical resistivity and is commonly measured in siemens per meter (S/m). 
                
                Materials with high conductivity, such as metals like copper and silver, allow electric charges to flow freely, making them excellent conductors.
                
                Electric conductivity is essential in applications ranging from electrical wiring to semiconductor design, where understanding how materials conduct electricity influences their performance and efficiency.
                
                For example, the conductivity of a material determines how much electrical current it can carry without significant energy loss.
                
                Accurate measurement of conductivity is critical in designing electrical components, optimizing power systems, and ensuring the safety and efficiency of electrical devices.
                """
        case .electricFieldStrength:
            return """
                Electric field strength, also known as electric field intensity, measures the force exerted per unit charge at a given point within an electric field. It indicates how strongly an electric field can influence a charged particle.
                
                The SI unit for electric field strength is volts per meter (V/m). For example, an electric field strength of 1 V/m means that a 1-volt potential difference exists between two points that are 1 meter apart.
                
                Electric field strength is fundamental in understanding the behavior of charges in electric fields and is crucial in applications like capacitors, where it determines how much charge can be stored, and in telecommunications, where it influences signal propagation.
                
                Precise measurement and control of electric field strength are essential for designing efficient electrical and electronic systems and ensuring their proper operation.
                """
        case .electricPotential:
            return """
                Electric potential, also known as voltage, measures the potential energy per unit charge at a specific point in an electric field. It represents the work needed to move a positive charge from a reference point (usually infinity) to the point in question.
                
                The SI unit for electric potential is the volt (V), where one volt equals one joule per coulomb (J/C). 
                
                For example, a battery that provides a potential difference of 12 volts can do 12 joules of work for each coulomb of charge it moves.
                
                Electric potential is a fundamental concept in electrical circuits, determining the energy available to drive current through a circuit.
                
                It is crucial in designing and analyzing electrical and electronic systems, ensuring that components operate at the correct voltage levels for optimal performance.
                """
        case .electricResistance:
            return """
                Electric resistance measures a material's opposition to the flow of electric current, indicating how much it resists the movement of electric charges.
                
                The SI unit for electric resistance is the ohm (Ω), where one ohm is defined as the resistance that produces a one-volt potential difference when a one-ampere current flows through it. For example, if a resistor has a resistance of 10 ohms, it will cause a 10-volt drop in potential when a 1-ampere current flows through it.
                
                Resistance is a key concept in electrical and electronic circuits, affecting the performance and efficiency of devices.
                
                Materials with high resistance, such as insulators, impede the flow of current, while conductors, like metals, have low resistance.
                
                Understanding and controlling resistance is crucial in designing circuits to ensure they function correctly and safely.
                """
        case .electricResistivity:
            return """
                Electric resistivity is a fundamental property of materials that quantifies how strongly they resist the flow of electric current. It is the intrinsic resistance of a material, independent of its shape or size, and is measured in ohm meters (Ω·m).
                
                A higher resistivity indicates that a material is a poor conductor of electricity, such as rubber or glass, while a lower resistivity suggests good conductivity, as seen in metals like copper and silver.
                
                For example, copper's low resistivity makes it ideal for electrical wiring.
                
                Electric resistivity is crucial in material science and electrical engineering, as it determines the efficiency and suitability of materials for various applications.
                
                Accurate knowledge of resistivity is essential for designing and optimizing electronic components, ensuring that they perform efficiently and safely in circuits and systems.
                """
        case .electrostaticCapacitance:
            return """
                Electrostatic capacitance measures a component's ability to store electric charge in an electric field, commonly in a capacitor. It quantifies how much charge a capacitor can store per unit voltage applied across its plates.
                
                The SI unit for capacitance is the farad (F), where one farad equals one coulomb of charge stored per volt. However, most practical capacitors are rated in microfarads (µF) or picofarads (pF) due to the large size of a farad.
                
                For example, a capacitor with a capacitance of 10 µF can store 10 microcoulombs of charge for every volt applied.
                
                Capacitance is crucial in electronic circuits, where capacitors are used for various purposes, including filtering, energy storage, and timing applications.
                
                Understanding and accurately measuring capacitance is essential for designing and optimizing electronic devices, ensuring that they function correctly and efficiently in their intended applications.
                """
        case .inductance:
            return """
                Inductance is a property of an electrical circuit or component that opposes changes in current flow, storing energy in a magnetic field. It is a measure of how effectively a coil or inductor can induce an electromotive force (EMF) in itself or another nearby coil when the current through it changes.
                
                The SI unit for inductance is the henry (H), where one henry is defined as the amount of inductance required to induce one volt of EMF when the current changes at a rate of one ampere per second.
                
                For example, an inductor with an inductance of 1 H will generate 1 volt of EMF when the current through it changes by 1 ampere per second.
                
                Inductance plays a crucial role in various applications, such as in transformers, electric motors, and filters, where it helps in controlling current flow, energy storage, and signal processing.
                
                Accurate measurement and management of inductance are essential for designing efficient and effective electrical and electronic systems.
                """
        case .linearChargeDensity:
            return """
                Linear charge density measures the amount of electric charge per unit length along a line or wire. It quantifies how charge is distributed along a linear conductor or along a charged line.
                
                The SI unit for linear charge density is the coulomb per meter (C/m).
                
                For example, if a charged wire has a linear charge density of 2 µC/m, it means there are 2 microcoulombs of charge distributed along every meter of the wire.
                
                Linear charge density is important in electrostatics for understanding the electric field created by long, thin conductors and in applications such as transmission lines and charged rods.
                
                Accurate measurement and calculation of linear charge density are crucial for predicting electric fields and forces in various electrical and electronic systems.
                """
        case .linearCurrentDensity:
            return """
                Linear current density measures the electric current flowing per unit length of a conductor. It indicates how much current is distributed along a given length of a wire or conductor.
                
                The SI unit for linear current density is amperes per meter (A/m).
                
                For example, if a wire carries a current of 5 amperes and has a linear current density of 2 A/m, it means that each meter of the wire conducts 2 amperes of current.
                
                Linear current density is crucial in the design and analysis of electrical circuits, particularly in understanding the distribution of current along conductors and ensuring that the conductors are capable of handling the required current without excessive heating or loss.
                
                Accurate measurement of linear current density helps in optimizing the performance and safety of electrical and electronic systems.
                """
        case .surfaceChargeDensity:
            return """
                Surface charge density measures the amount of electric charge per unit area on a surface. It quantifies how charge is distributed over a two-dimensional surface, such as that of a charged plate or conductor.
                
                The SI unit for surface charge density is coulombs per square meter (C/m²). For example, if a charged plate has a surface charge density of 3 µC/m², it means there are 3 microcoulombs of charge distributed over each square meter of the plate’s surface.
                
                Surface charge density is important in electrostatics for understanding the electric field and potential created by charged surfaces, as well as in applications such as capacitors, sensors, and electrostatic precipitators.
                
                Accurate measurement and control of surface charge density are essential for designing and optimizing devices that rely on surface charge effects.
                """
        case .surfaceCurrentDensity:
            return """
                Surface current density measures the amount of electric current flowing per unit length along a surface. It indicates how much current is distributed over a two-dimensional surface, such as a conductor or a thin film.
                
                The SI unit for surface current density is amperes per meter (A/m).
                
                For example, if a thin film has a surface current density of 4 A/m, it means that each meter length of the surface carries a current of 4 amperes.
                
                Surface current density is important in understanding and designing various electrical and electronic devices, such as thin-film conductors, antennas, and superconductors.
                
                Accurate measurement and management of surface current density are essential for optimizing the performance and efficiency of devices where current distribution over a surface impacts their functionality.
                """
        case .volumeChargeDensity:
            return """
                Volume charge density measures the amount of electric charge per unit volume within a three-dimensional region of space. It quantifies how charge is distributed throughout a volume, such as inside a charged object or a semiconductor.
                
                The SI unit for volume charge density is coulombs per cubic meter (C/m³). For example, if a region has a volume charge density of 5 µC/m³, it means there are 5 microcoulombs of charge distributed throughout each cubic meter of that region.
                
                Volume charge density is crucial in electrostatics for understanding the electric field and potential created by charges distributed in a volume, as well as in applications like dielectric materials and charge storage devices.
                
                Accurate measurement of volume charge density is essential for predicting electric fields and designing devices that rely on volumetric charge distributions.
                """
        }
    }
    
    var availableUnits: [(symbol: String, name: String)] {
        switch self {
        case .charge:
            return [
                ("C", "coulomb"),
                ("MC", "megacoulomb"),
                ("kC", "kilocoulomb"),
                ("mC", "millicoulomb"),
                ("µC", "microcoulomb"),
                ("nC", "nanocoulomb"),
                ("pC", "picocoulomb"),
                ("abC", "abcoulomb"),
                ("emuC", "EMU of charge"),
                ("statC", "statcoulomb"),
                ("esuC", "ESU of charge"),
                ("Fr", "franklin"),
                ("A·h", "ampere-hour"),
                ("A·min", "ampere-minute"),
                ("A·s", "ampere-second"),
                ("F", "faraday (based on carbon 12)"),
                ("e", "Elementary charge")
            ]
        case .linearChargeDensity:
            return [
                ("C/m", "coulomb/meter"),
                ("C/cm", "coulomb/centimeter"),
                ("C/in", "coulomb/inch"),
                ("abC/m", "abcoulomb/meter"),
                ("abC/cm", "abcoulomb/centimeter"),
                ("abC/in", "abcoulomb/inch")
            ]
        case .surfaceChargeDensity:
            return [
                ("C/m²", "coulomb/square meter"),
                ("C/cm²", "coulomb/square centimeter"),
                ("C/in²", "coulomb/square inch"),
                ("abC/m²", "abcoulomb/square meter"),
                ("abC/cm²", "abcoulomb/square centimeter"),
                ("abC/in²", "abcoulomb/square inch")
            ]
        case .volumeChargeDensity:
            return [
                ("C/m³", "coulomb/cubic meter"),
                ("C/cm³", "coulomb/cubic centimeter"),
                ("C/in³", "coulomb/cubic inch"),
                ("abC/m³", "abcoulomb/cubic meter"),
                ("abC/cm³", "abcoulomb/cubic centimeter"),
                ("abC/in³", "abcoulomb/cubic inch")
            ]
        case .current:
            return [
                ("A", "ampere"),
                ("kA", "kiloampere"),
                ("mA", "milliampere"),
                ("Bi", "biot"),
                ("abA", "abampere"),
                ("emuI", "EMU of current"),
                ("statA", "statampere"),
                ("esuI", "ESU of current"),
                ("CGSem", "CGS e.m. unit"),
                ("CGSes", "CGS e.s. unit")
            ]
        case .linearCurrentDensity:
            return [
                ("A/m", "ampere/meter"),
                ("A/cm", "ampere/centimeter"),
                ("A/in", "ampere/inch"),
                ("abA/m", "abampere/meter"),
                ("abA/cm", "abampere/centimeter"),
                ("abA/in", "abampere/inch"),
                ("Oe", "oersted"),
                ("Gb/cm", "gilbert/centimeter")
            ]
        case .surfaceCurrentDensity:
            return [
                ("A/m²", "ampere/square meter"),
                ("A/cm²", "ampere/square centimeter"),
                ("A/in²", "ampere/square inch"),
                ("A/mil²", "ampere/square mil"),
                ("A/cmil", "ampere/circular mil"),
                ("abA/cm²", "abampere/square centimeter")
            ]
        case .electricFieldStrength:
            return [
                ("V/m", "volt/meter"),
                ("kV/m", "kilovolt/meter"),
                ("kV/cm", "kilovolt/centimeter"),
                ("V/cm", "volt/centimeter"),
                ("mV/m", "millivolt/meter"),
                ("µV/m", "microvolt/meter"),
                ("kV/in", "kilovolt/inch"),
                ("V/in", "volt/inch"),
                ("V/mil", "volt/mil"),
                ("abV/cm", "abvolt/centimeter"),
                ("statV/cm", "statvolt/centimeter"),
                ("statV/in", "statvolt/inch"),
                ("N/C", "newton/coulomb")
            ]
        case .electricPotential:
            return [
                ("V", "volt"),
                ("W/A", "watt/ampere"),
                ("abV", "abvolt"),
                ("emuV", "EMU of electric potential"),
                ("statV", "statvolt"),
                ("esuV", "ESU of electric potential")
            ]
        case .electricResistance:
            return [
                ("Ω", "ohm"),
                ("MΩ", "megohm"),
                ("µΩ", "microhm"),
                ("V/A", "volt/ampere"),
                ("S⁻¹", "reciprocal siemens"),
                ("abΩ", "abohm"),
                ("emuR", "EMU of resistance"),
                ("statΩ", "statohm"),
                ("esuR", "ESU of resistance"),
                ("RH", "Quantized Hall resistance")
            ]
        case .electricResistivity:
            return [
                ("Ω·m", "ohm meter"),
                ("Ω·cm", "ohm centimeter"),
                ("Ω·in", "ohm inch"),
                ("µΩ·cm", "microhm centimeter"),
                ("µΩ·in", "microhm inch"),
                ("abΩ·cm", "abohm centimeter"),
                ("statΩ·cm", "statohm centimeter"),
                ("cmil·Ω/ft", "circular mil ohm/foot")
            ]
        case .electricConductance:
            return [
                ("S", "siemens"),
                ("MS", "megasiemens"),
                ("kS", "kilosiemens"),
                ("mS", "millisiemens"),
                ("µS", "microsiemens"),
                ("A/V", "ampere/volt"),
                ("℧", "mho"),
                ("g℧", "gemmho"),
                ("µ℧", "micromho"),
                ("ab℧", "abmho"),
                ("stat℧", "statmho"),
                ("G₀", "Quantized Hall conductance")
            ]
        case .electricConductivity:
            return [
                ("S/m", "siemens/meter"),
                ("pS/m", "picosiemens/meter"),
                ("℧/m", "mho/meter"),
                ("℧/cm", "mho/centimeter"),
                ("ab℧/m", "abmho/meter"),
                ("ab℧/cm", "abmho/centimeter"),
                ("stat℧/m", "statmho/meter"),
                ("stat℧/cm", "statmho/centimeter")
            ]
        case .electrostaticCapacitance:
            return [
                ("F", "farad"),
                ("EF", "exafarad"),
                ("PF", "petafarad"),
                ("TF", "terafarad"),
                ("GF", "gigafarad"),
                ("MF", "megafarad"),
                ("kF", "kilofarad"),
                ("hF", "hectofarad"),
                ("daF", "dekafarad"),
                ("dF", "decifarad"),
                ("cF", "centifarad"),
                ("mF", "millifarad"),
                ("µF", "microfarad"),
                ("nF", "nanofarad"),
                ("pF", "picofarad"),
                ("fF", "femtofarad"),
                ("aF", "attofarad"),
                ("C/V", "coulomb/volt"),
                ("abF", "abfarad"),
                ("emuC", "EMU of capacitance"),
                ("statF", "statfarad"),
                ("esuC", "ESU of capacitance")
            ]
        case .inductance:
            return [
                ("H", "henry"),
                ("EH", "exahenry"),
                ("PH", "petahenry"),
                ("TH", "terahenry"),
                ("GH", "gigahenry"),
                ("MH", "megahenry"),
                ("kH", "kilohenry"),
                ("hH", "hectohenry"),
                ("daH", "dekahenry"),
                ("dH", "decihenry"),
                ("cH", "centihenry"),
                ("mH", "millihenry"),
                ("µH", "microhenry"),
                ("nH", "nanohenry"),
                ("pH", "picohenry"),
                ("fH", "femtohenry"),
                ("aH", "attohenry"),
                ("Wb/A", "weber/ampere"),
                ("abH", "abhenry"),
                ("emuL", "EMU of inductance"),
                ("statH", "stathenry"),
                ("esuL", "ESU of inductance")
            ]
        }
    }}
