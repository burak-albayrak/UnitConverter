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
    
    var availableUnits: [Dimension] {
        switch self {
        case .charge:
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
        case .current:
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
        case .electricConductance:
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
            
        case .electricConductivity:
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
            
        case .electricFieldStrength:
            return [UnitTemperature.celsius,
                    UnitTemperature.fahrenheit,
                    UnitTemperature.kelvin]
            
        case .electricPotential:
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
            
        case .electricResistance:
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
            
        case .electricResistivity:
            return [
                UnitAngle.degrees,
                UnitAngle.arcMinutes,
                UnitAngle.arcSeconds,
                UnitAngle.radians,
                UnitAngle.gradians,
                UnitAngle.revolutions
            ]
            
        case .electrostaticCapacitance:
            return [
                UnitSpeed.metersPerSecond,
                UnitSpeed.kilometersPerHour,
                UnitSpeed.milesPerHour,
                UnitSpeed.knots
            ]
            
        case .inductance:
            return [
                UnitDuration.hours,
                UnitDuration.minutes,
                UnitDuration.seconds,
                UnitDuration.milliseconds,
                UnitDuration.microseconds,
                UnitDuration.nanoseconds,
                UnitDuration.picoseconds
            ]
            
        case .linearChargeDensity:
            return [
                UnitDuration.hours,
                UnitDuration.minutes,
                UnitDuration.seconds,
                UnitDuration.milliseconds,
                UnitDuration.microseconds,
                UnitDuration.nanoseconds,
                UnitDuration.picoseconds
            ]
        case .linearCurrentDensity:
            return [
                UnitDuration.hours,
                UnitDuration.minutes,
                UnitDuration.seconds,
                UnitDuration.milliseconds,
                UnitDuration.microseconds,
                UnitDuration.nanoseconds,
                UnitDuration.picoseconds
            ]
        case .surfaceChargeDensity:
            return [
                UnitDuration.hours,
                UnitDuration.minutes,
                UnitDuration.seconds,
                UnitDuration.milliseconds,
                UnitDuration.microseconds,
                UnitDuration.nanoseconds,
                UnitDuration.picoseconds
            ]
        case .surfaceCurrentDensity:
            return [
                UnitDuration.hours,
                UnitDuration.minutes,
                UnitDuration.seconds,
                UnitDuration.milliseconds,
                UnitDuration.microseconds,
                UnitDuration.nanoseconds,
                UnitDuration.picoseconds
            ]
        case .volumeChargeDensity:
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
        case .charge:
            return ["Degrees", "Arc Minutes", "Arc Seconds", "Radians", "Gradians", "Revolutions"]
        case .current:
            return ["Degrees", "Arc Minutes", "Arc Seconds", "Radians", "Gradians", "Revolutions"]
        case .electricConductance:
            return ["Degrees", "Arc Minutes", "Arc Seconds", "Radians", "Gradians", "Revolutions"]
        case .electricConductivity:
            return ["Degrees", "Arc Minutes", "Arc Seconds", "Radians", "Gradians", "Revolutions"]
        case .electricFieldStrength:
            return ["Degrees", "Arc Minutes", "Arc Seconds", "Radians", "Gradians", "Revolutions"]
        case .electricPotential:
            return ["Degrees", "Arc Minutes", "Arc Seconds", "Radians", "Gradians", "Revolutions"]
        case .electricResistance:
            return ["Degrees", "Arc Minutes", "Arc Seconds", "Radians", "Gradians", "Revolutions"]
        case .electricResistivity:
            return ["Degrees", "Arc Minutes", "Arc Seconds", "Radians", "Gradians", "Revolutions"]
        case .electrostaticCapacitance:
            return ["Degrees", "Arc Minutes", "Arc Seconds", "Radians", "Gradians", "Revolutions"]
        case .inductance:
            return ["Degrees", "Arc Minutes", "Arc Seconds", "Radians", "Gradians", "Revolutions"]
        case .linearChargeDensity:
            return ["Degrees", "Arc Minutes", "Arc Seconds", "Radians", "Gradians", "Revolutions"]
        case .linearCurrentDensity:
            return ["Degrees", "Arc Minutes", "Arc Seconds", "Radians", "Gradians", "Revolutions"]
        case .surfaceChargeDensity:
            return ["Degrees", "Arc Minutes", "Arc Seconds", "Radians", "Gradians", "Revolutions"]
        case .surfaceCurrentDensity:
            return ["Degrees", "Arc Minutes", "Arc Seconds", "Radians", "Gradians", "Revolutions"]
        case .volumeChargeDensity:
            return ["Degrees", "Arc Minutes", "Arc Seconds", "Radians", "Gradians", "Revolutions"]

        }
    }
}
