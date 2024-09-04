//
//  EngineeringUnitsModel.swift
//  UnitConverter
//
//  Created by Burak Albayrak on 31.08.2024.
//

import Foundation

enum EngineeringUnitsCategory: String, CaseIterable, UnitCategory {
    case length = "Length"
    case mass = "Weight and Mass"
    case volume = "Volume"
    case temperature = "Temperature"
    case area = "Area"
    case pressure = "Pressure"
    case angle = "Angle"
    case speed = "Speed"
    case duration = "Duration"
    case energy = "Energy"
    case power = "Power"
    case force = "Force"
    case fuelConsuption = "Fuel Consuption"
    case numbers = "Numbers"
    case dataStorage = "Data Storage"
    case volumeDry = "Volume - Dry"
    case velocityAngular = "Velocity - Angular"
    case acceleration = "Acceleration"
    case accelerationAngular = "Acceleration - Angular"
    case density = "Density"
    case spesificVolume = "Spesific Volume"
    case momentOfInertia = "Moment of Inertia"
    case momentOfForce = "Moment of Force"
    case torque = "Torque"
    
    var icon: String {
        switch self {
        case .mass:
            return "scalemass"
        case .length:
            return "ruler"
        case .area:
            return "skew"
        case .volume:
            return "pyramid"
        case .pressure:
            return "barometer"
        case .temperature:
            return "thermometer"
        case .angle:
            return "angle"
        case .speed:
            return "gauge.with.dots.needle.67percent"
        case .duration:
            return "stopwatch"
        case .energy:
            return "bolt"
        case .power:
            return "power" // TODO: daha iyisini bul
        case .force:
            return "arrow.left.arrow.right" // TODO: daha iyisini bul
        case .fuelConsuption:
            return "fuelpump"
        case .numbers:
            return "numbersign" // TODO: daha iyisini bul
        case .dataStorage:
            return "externaldrive"
        case .volumeDry:
            return "speaker.wave.2"
        case .velocityAngular:
            return "arrow.clockwise"
        case .acceleration:
            return "gauge.open.with.lines.needle.84percent.exclamation" // TODO: daha iyisini bul
        case .accelerationAngular:
            return "digitalcrown.arrow.clockwise" // TODO: daha iyisini bul
        case .density:
            return "circle.dotted.and.circle" // TODO: daha iyisini bul
        case .spesificVolume:
            return "cube"
        case .momentOfInertia:
            return "arrow.right.arrow.left" // TODO: daha iyisini bul
        case .momentOfForce:
            return "circle" // TODO: daha iyisini bul
        case .torque:
            return "gearshape" // TODO: daha iyisini bul
        }
    }
    
    var info: String {
        switch self {
        case .mass:
            return """
            Mass measures the amount of matter in an object, and its SI unit is the kilogram (kg). It is a fundamental property of physical objects and remains constant regardless of location.
            
            Mass is used to quantify the resistance of an object to acceleration when a force is applied.

            Weight, on the other hand, is the force exerted by gravity on an object’s mass. Its SI unit is the newton (N), defined as the force needed to accelerate a one-kilogram mass by one meter per second squared.
            
            Weight varies depending on the gravitational field strength of the location. For example, an object weighs less on the Moon than on Earth due to the Moon’s weaker gravity.
            
            Both weight and mass are crucial in physics and engineering, but they measure different properties of matter.
            """
        case .length:
            return """
                Length is a measure of how long an object is from one end to the other. It is one of the fundamental dimensions in physics and engineering.
                
                In the International System of Units (SI), the base unit for length is the meter (m).
                
                Length can be measured in various units, such as kilometers (km), centimeters (cm), and millimeters (mm), each of which is a derived unit based on the meter.
                
                For example, one kilometer equals 1,000 meters, and one centimeter equals 0.01 meters. These units are used in everyday life, scientific research, and engineering to quantify the size or extent of objects and distances.
                """
        case .area:
            return """
            Area measures the extent of a two-dimensional surface or shape. It quantifies the amount of space within a boundary and is a key concept in geometry, architecture, and various scientific fields.
            
            The SI unit for area is the square meter (m²), which represents the area of a square with sides of one meter.
            
            Other commonly used units include square kilometers (km²), square centimeters (cm²), and square millimeters (mm²). For instance, one square kilometer equals one million square meters.
            
            Area is used to determine the size of land plots, the surface of objects, and the amount of material needed for coverage. Accurate area calculations are essential in tasks ranging from land surveying to designing floor plans.
            """
        case .volume:
            return """
                Volume refers to the amount of three-dimensional space an object or substance occupies. It is a critical measurement in various scientific and practical applications, including fluid dynamics, engineering, and everyday life.
                
                The SI unit for volume is the cubic meter (m³), which represents the space occupied by a cube with sides of one meter in length.
                
                Other common units include liters (L), where one liter equals one cubic decimeter (dm³), and milliliters (mL), where one milliliter equals one cubic centimeter (cm³).
                
                Volume measurements are essential for determining quantities in cooking, filling containers, and calculating capacities in engineering tasks. Understanding volume is fundamental for working with liquids, gases, and solids.
                """
        case .pressure:
            return """
                Pressure is the force exerted per unit area on the surface of an object. It is a fundamental concept in physics and engineering, relevant to gases, liquids, and solids.
                
                The SI unit of pressure is the pascal (Pa), defined as one newton per square meter (N/m²).
                
                Pressure can also be measured in other units, such as atmospheres (atm), where one atmosphere equals 101,325 pascals, and bar, where one bar is equal to 100,000 pascals.
                
                Pressure is crucial in various applications, including fluid dynamics, meteorology, and engineering.
                
                It helps in understanding phenomena like weather patterns, hydraulic systems, and gas laws, and is essential for designing equipment that operates under different pressure conditions.
                """
        case .temperature:
            return """
                Temperature measures the thermal energy or heat within a substance, indicating how hot or cold it is. It is a fundamental physical quantity used in various scientific and everyday contexts.
                
                The SI unit for temperature is the kelvin (K), where zero kelvin (0 K) represents absolute zero, the point at which atomic motion ceases.
                
                Temperature is also commonly measured in degrees Celsius (°C) and degrees Fahrenheit (°F). In the Celsius scale, water freezes at 0°C and boils at 100°C under standard atmospheric conditions. In Fahrenheit, water freezes at 32°F and boils at 212°F.
                
                Accurate temperature measurement is vital for processes ranging from weather forecasting to chemical reactions and everyday temperature control.
                """
        case .angle:
            return """
                An angle represents the space between two intersecting lines or surfaces, measured in degrees or radians. It is a fundamental concept in geometry and trigonometry.
                
                The SI unit for angles is the radian (rad), where one radian is the angle formed when the arc length of a circle is equal to the radius.
                
                Another common unit is the degree (°), where a full circle is divided into 360 degrees. For example, a right angle is 90°, and a full circle is 360°.
                
                Angles are essential in various fields such as navigation, engineering, and physics, helping to describe rotations, slopes, and the orientation of objects. Accurate angle measurement is crucial for precise calculations and designs.
                """
        case .speed:
            return """
                Speed measures the rate at which an object moves or changes its position over time. It is a fundamental concept in physics and everyday life, describing how quickly something travels.
                
                The SI unit for speed is meters per second (m/s), representing the distance covered in meters within one second.
                
                Other common units include kilometers per hour (km/h) and miles per hour (mph). For example, a car traveling at 60 km/h covers 60 kilometers in one hour.
                
                Speed is essential in various applications, from vehicle performance and sports to scientific experiments and navigation.
                
                Understanding speed is crucial for analyzing motion, optimizing performance, and ensuring safety in different contexts.
                """
        case .duration:
            return """
                Duration refers to the total time interval during which an event or activity occurs. It measures how long something lasts, from its start to its end.
                
                Duration is a fundamental concept in timekeeping and planning, used to quantify the length of various activities, from short tasks to long-term projects.
                
                The SI unit for duration is the second (s), but it is often expressed in larger units such as minutes, hours, days, or even years.
                
                For instance, an event lasting 5 minutes is measured as 300 seconds.
                
                Accurate duration measurement is crucial for scheduling, project management, and time-based calculations in diverse fields including science, engineering, and daily life.
                """
        case .energy:
            return """
                Energy is a fundamental physical quantity representing the ability to perform work or cause change. It exists in various forms, such as kinetic, potential, thermal, and chemical.
                
                The SI unit for energy is the joule (J), which is defined as the amount of work done when a force of one newton displaces an object by one meter.
                
                Other units include calories (cal) and kilowatt-hours (kWh). For example, one kilowatt-hour equals 3.6 million joules.
                
                Energy is a central concept in physics, chemistry, and engineering, essential for understanding processes like heat transfer, mechanical work, and power generation.
                
                Accurate energy measurement is vital for optimizing efficiency and managing resources in both everyday applications and advanced technologies.
                """
        case .power:
            return """
                Power measures the rate at which work is done or energy is transferred over time. It quantifies how quickly energy is used or produced and is a key concept in both physics and engineering.
                
                The SI unit for power is the watt (W), defined as one joule per second (J/s). For instance, a 100-watt light bulb consumes 100 joules of energy every second it is operating.
                
                Other units of power include horsepower (hp), where one horsepower is approximately 745.7 watts. Power is crucial in various applications, from electrical systems and mechanical engines to energy management and renewable resources.
                
                Understanding power helps in designing efficient systems and optimizing performance in both industrial and everyday contexts.
                """
        case .force:
            return """
                Force is an interaction that changes the motion of an object or causes it to accelerate. It is a vector quantity, meaning it has both magnitude and direction.
                
                The SI unit for force is the newton (N), which is defined as the amount of force required to accelerate a one-kilogram mass by one meter per second squared.
                
                For example, one newton is the force needed to lift a small apple against Earth's gravity. Force is a fundamental concept in mechanics and physics, essential for understanding phenomena such as gravity, friction, and tension.
                
                Accurate measurement of force is crucial for designing structures, machinery, and various systems where precise control and stability are required.
                """
        case .fuelConsuption:
            return """
                Fuel consumption measures the amount of fuel used by a vehicle or machine over a specific distance or period. It is an important metric for assessing efficiency and environmental impact.
                
                The SI unit for fuel consumption is liters per 100 kilometers (L/100 km), indicating how many liters of fuel are needed to travel 100 kilometers.
                
                Another common unit is miles per gallon (mpg), used primarily in the United States, where a higher mpg value signifies better fuel efficiency.
                
                Fuel consumption is crucial for evaluating the performance of engines, optimizing operational costs, and reducing emissions.
                
                Accurate measurement and management of fuel consumption are essential for both economic and environmental reasons.
                """
        case .numbers:
            return """
                Numbers are fundamental mathematical objects used to quantify, measure, and label. They represent values and can be classified into various types, such as natural numbers, integers, rational numbers, and real numbers.
                
                The most basic numbers are natural numbers (1, 2, 3, …), which are used for counting. Integers include both positive and negative whole numbers.
                
                Rational numbers are fractions or ratios of integers, while real numbers encompass all possible values along a continuous line, including irrational numbers like √2. 
                
                Numbers are essential in mathematics, science, and daily life for performing calculations, analyzing data, and making decisions.
                
                Accurate number representation and manipulation are crucial for solving problems and understanding various phenomena.
                """
        case .dataStorage:
            return """
                Data storage refers to the method of recording, preserving, and retrieving digital information. It involves various media and technologies used to save data for future use.
                
                Common data storage units include bytes, kilobytes (KB), megabytes (MB), gigabytes (GB), and terabytes (TB), each representing a specific amount of data.
                
                Storage devices can be categorized into primary storage, such as RAM (Random Access Memory) which provides quick access to data, and secondary storage, like hard drives (HDDs), solid-state drives (SSDs), and optical discs, which store data more permanently.
                
                Data storage is essential for managing large volumes of information, ensuring data integrity, and enabling efficient access and retrieval for applications ranging from personal computing to enterprise systems.
                """
        case .volumeDry:
            return """
                Dry volume measures the amount of space occupied by a solid substance or dry material, typically in agricultural, culinary, and scientific contexts.
                
                Unlike liquid volume, which deals with fluids, dry volume quantifies the space taken up by non-liquid substances.
                
                Common units for dry volume include cubic meters (m³), liters (L), and bushels. For example, a bushel is often used in agriculture to measure grains and fruits, where one bushel is equivalent to about 35.24 liters.
                
                Accurate measurement of dry volume is crucial for tasks such as portion control in cooking, inventory management, and agricultural yield estimation.
                
                Understanding dry volume helps in efficient material handling and precise measurement in various fields.
                """
        case .velocityAngular:
            return """
                Angular velocity measures the rate at which an object rotates around an axis. It quantifies how quickly an angle changes with respect to time and is a key concept in rotational motion.
                
                The SI unit for angular velocity is radians per second (rad/s). One radian represents the angle subtended when the arc length of a circle equals the radius.
                
                For example, an angular velocity of 2 rad/s means the angle of rotation increases by 2 radians every second. Angular velocity is essential in fields such as physics, engineering, and astronomy for analyzing rotational dynamics, machinery performance, and celestial movements.
                
                Accurate measurement of angular velocity is crucial for designing rotating systems and understanding rotational behavior.
                """
        case .acceleration:
            return """
                Acceleration measures the rate at which an object's velocity changes over time. It is a fundamental concept in mechanics and physics, describing how quickly an object speeds up or slows down.
                
                The SI unit for acceleration is meters per second squared (m/s²), indicating the change in velocity (in meters per second) that occurs each second.
                
                For example, an acceleration of 9.8 m/s² represents the acceleration due to Earth's gravity, causing objects to speed up by 9.8 meters per second each second when falling freely.
                
                Acceleration is crucial for understanding motion dynamics, designing vehicles, and analyzing forces in various applications.
                
                Accurate measurement of acceleration helps in predicting and controlling the movement of objects and systems.
                """
        case .accelerationAngular:
            return """
                Angular acceleration measures the rate at which an object's angular velocity changes over time. It describes how quickly an object speeds up or slows down its rotation around an axis.
                
                The SI unit for angular acceleration is radians per second squared (rad/s²), which represents the change in angular velocity (in radians per second) that occurs each second.
                
                For example, if an object's angular velocity increases by 2 rad/s every second, its angular acceleration is 2 rad/s².
                
                Angular acceleration is crucial in rotational dynamics, affecting the performance of rotating machinery, the motion of celestial bodies, and the behavior of various mechanical systems.
                
                Accurate measurement of angular acceleration helps in designing and analyzing rotational systems and understanding rotational motion.
                """
        case .density:
            return """
                Density is a measure of how much mass is contained in a given volume. It is an important property in physics and engineering that helps in understanding the distribution of mass within a substance.
                
                The SI unit for density is kilograms per cubic meter (kg/m³). 
                
                For example, the density of water is approximately 1,000 kg/m³, meaning one cubic meter of water has a mass of 1,000 kilograms.
                
                Density can also be expressed in other units, such as grams per cubic centimeter (g/cm³), where 1 g/cm³ equals 1,000 kg/m³. 
                
                Density is used to identify materials, determine buoyancy, and analyze the behavior of substances under various conditions.
                
                Accurate density measurement is crucial for material science, fluid dynamics, and engineering applications.
                """
        case .spesificVolume:
            return """
                Specific volume is a property that measures the volume occupied by a unit mass of a substance. It is the reciprocal of density and provides insights into the space a given mass occupies.
                
                The SI unit for specific volume is cubic meters per kilogram (m³/kg).
                
                For example, if a substance has a density of 2 kg/m³, its specific volume would be 0.5 m³/kg, meaning one kilogram of the substance occupies 0.5 cubic meters.
                
                Specific volume is crucial in thermodynamics and fluid mechanics for analyzing the behavior of gases and liquids, especially in processes involving changes in pressure and temperature.
                
                Accurate measurement of specific volume helps in designing systems like compressors, engines, and various other equipment where precise volume and mass relationships are important.
                """
        case .momentOfInertia:
            return """
                Moment of inertia, also known as the rotational inertia, measures an object's resistance to changes in its rotational motion about an axis. It depends on the mass distribution relative to the axis of rotation.
                
                The SI unit for moment of inertia is kilogram square meters (kg·m²).
                
                For example, a solid cylinder rotating about its central axis has a different moment of inertia compared to a hollow cylinder with the same mass and radius.
                
                The moment of inertia is crucial in rotational dynamics and is used to calculate angular acceleration, torque, and kinetic energy in rotating systems. 
                
                Accurate determination of moment of inertia is essential for designing and analyzing mechanical systems, including wheels, gears, and flywheels, where rotational motion plays a significant role.
                """
        case .momentOfForce:
            return """
                The moment of force, also known as torque, measures the rotational effect produced by a force applied at a distance from a pivot point or axis. It quantifies how much a force tends to rotate an object around an axis.
                
                The SI unit for moment of force is the newton meter (N·m).
                
                For example, applying a force of 10 newtons at a distance of 2 meters from the pivot generates a moment of force of 20 N·m. The moment of force is crucial in mechanics for analyzing rotational motion, balancing forces, and designing mechanical systems such as engines and levers.
                
                Accurate calculation of torque helps ensure the proper functioning and stability of structures and machinery under rotational loads.
                """
        case .torque:
            return """
                Torque, also known as the moment of force, measures the tendency of a force to rotate an object around an axis or pivot point. It is a crucial concept in rotational dynamics and engineering. 
                
                The SI unit for torque is the newton meter (N·m), representing the force applied at a perpendicular distance from the axis of rotation.
                
                For example, tightening a bolt with a wrench involves applying a force at a certain distance from the bolt, generating torque that secures the bolt in place.
                
                Torque is essential for understanding mechanical systems, including engines, gears, and various machinery.
                
                Accurate torque measurement ensures proper operation and efficiency of rotating equipment and helps in balancing and controlling rotational forces.
                """
        }
    }
    
    var availableUnits: [Dimension] {
        switch self {
        case .acceleration:
            return [
                UnitAcceleration.gravity,
                UnitAcceleration.metersPerSecondSquared
            ]
            
        case .accelerationAngular:
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
            
        case .angle:
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
            
        case .area:
            return [UnitTemperature.celsius,
                    UnitTemperature.fahrenheit,
                    UnitTemperature.kelvin]
            
        case .dataStorage:
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
            
        case .density:
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
            
        case .duration:
            return [
                UnitAngle.degrees,
                UnitAngle.arcMinutes,
                UnitAngle.arcSeconds,
                UnitAngle.radians,
                UnitAngle.gradians,
                UnitAngle.revolutions
            ]
            
        case .energy:
            return [
                UnitSpeed.metersPerSecond,
                UnitSpeed.kilometersPerHour,
                UnitSpeed.milesPerHour,
                UnitSpeed.knots
            ]
            
        case .force:
            return [
                UnitDuration.hours,
                UnitDuration.minutes,
                UnitDuration.seconds,
                UnitDuration.milliseconds,
                UnitDuration.microseconds,
                UnitDuration.nanoseconds,
                UnitDuration.picoseconds
            ]
            
        case .fuelConsuption:
            return [
                UnitDuration.hours,
                UnitDuration.minutes,
                UnitDuration.seconds,
                UnitDuration.milliseconds,
                UnitDuration.microseconds,
                UnitDuration.nanoseconds,
                UnitDuration.picoseconds
            ]            
        case .length:
            return [
                UnitDuration.hours,
                UnitDuration.minutes,
                UnitDuration.seconds,
                UnitDuration.milliseconds,
                UnitDuration.microseconds,
                UnitDuration.nanoseconds,
                UnitDuration.picoseconds
            ]            
        case .mass:
            return [
                UnitDuration.hours,
                UnitDuration.minutes,
                UnitDuration.seconds,
                UnitDuration.milliseconds,
                UnitDuration.microseconds,
                UnitDuration.nanoseconds,
                UnitDuration.picoseconds
            ]            
        case .momentOfForce:
            return [
                UnitDuration.hours,
                UnitDuration.minutes,
                UnitDuration.seconds,
                UnitDuration.milliseconds,
                UnitDuration.microseconds,
                UnitDuration.nanoseconds,
                UnitDuration.picoseconds
            ]            
        case .momentOfInertia:
            return [
                UnitDuration.hours,
                UnitDuration.minutes,
                UnitDuration.seconds,
                UnitDuration.milliseconds,
                UnitDuration.microseconds,
                UnitDuration.nanoseconds,
                UnitDuration.picoseconds
            ]            
        case .numbers:
            return [
                UnitDuration.hours,
                UnitDuration.minutes,
                UnitDuration.seconds,
                UnitDuration.milliseconds,
                UnitDuration.microseconds,
                UnitDuration.nanoseconds,
                UnitDuration.picoseconds
            ]            
        case .power:
            return [
                UnitDuration.hours,
                UnitDuration.minutes,
                UnitDuration.seconds,
                UnitDuration.milliseconds,
                UnitDuration.microseconds,
                UnitDuration.nanoseconds,
                UnitDuration.picoseconds
            ]            
        case .pressure:
            return [
                UnitDuration.hours,
                UnitDuration.minutes,
                UnitDuration.seconds,
                UnitDuration.milliseconds,
                UnitDuration.microseconds,
                UnitDuration.nanoseconds,
                UnitDuration.picoseconds
            ]            
        case .speed:
            return [
                UnitDuration.hours,
                UnitDuration.minutes,
                UnitDuration.seconds,
                UnitDuration.milliseconds,
                UnitDuration.microseconds,
                UnitDuration.nanoseconds,
                UnitDuration.picoseconds
            ]            
        case .spesificVolume:
            return [
                UnitDuration.hours,
                UnitDuration.minutes,
                UnitDuration.seconds,
                UnitDuration.milliseconds,
                UnitDuration.microseconds,
                UnitDuration.nanoseconds,
                UnitDuration.picoseconds
            ]            
        case .temperature:
            return [
                UnitDuration.hours,
                UnitDuration.minutes,
                UnitDuration.seconds,
                UnitDuration.milliseconds,
                UnitDuration.microseconds,
                UnitDuration.nanoseconds,
                UnitDuration.picoseconds
            ]
        case .torque:
            return [
                UnitDuration.hours,
                UnitDuration.minutes,
                UnitDuration.minutes,
                UnitDuration.minutes,
                UnitDuration.seconds,
                UnitDuration.milliseconds,
                UnitDuration.microseconds,
                UnitDuration.nanoseconds,
                UnitDuration.picoseconds
            ]            
        case .velocityAngular:
            return [
                UnitDuration.hours,
                UnitDuration.minutes,
                UnitDuration.seconds,
                UnitDuration.milliseconds,
                UnitDuration.microseconds,
                UnitDuration.nanoseconds,
                UnitDuration.picoseconds
            ]            
        case .volume:
            return [
                UnitDuration.hours,
                UnitDuration.minutes,
                UnitDuration.seconds,
                UnitDuration.milliseconds,
                UnitDuration.microseconds,
                UnitDuration.nanoseconds,
                UnitDuration.picoseconds
            ]            
        case .volumeDry:
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
        case .acceleration:
            return ["Degrees", "Arc Minutes", "Arc Seconds", "Radians", "Gradians", "Revolutions"]
        case .accelerationAngular:
            return ["Degrees", "Arc Minutes", "Arc Seconds", "Radians", "Gradians", "Revolutions"]
        case .angle:
            return ["Degrees", "Arc Minutes", "Arc Seconds", "Radians", "Gradians", "Revolutions"]
        case .area:
            return ["Degrees", "Arc Minutes", "Arc Seconds", "Radians", "Gradians", "Revolutions"]
        case .dataStorage:
            return ["Degrees", "Arc Minutes", "Arc Seconds", "Radians", "Gradians", "Revolutions"]
        case .density:
            return ["Degrees", "Arc Minutes", "Arc Seconds", "Radians", "Gradians", "Revolutions"]
        case .duration:
            return ["Degrees", "Arc Minutes", "Arc Seconds", "Radians", "Gradians", "Revolutions"]
        case .energy:
            return ["Degrees", "Arc Minutes", "Arc Seconds", "Radians", "Gradians", "Revolutions"]
        case .force:
            return ["Degrees", "Arc Minutes", "Arc Seconds", "Radians", "Gradians", "Revolutions"]
        case .fuelConsuption:
            return ["Degrees", "Arc Minutes", "Arc Seconds", "Radians", "Gradians", "Revolutions"]
        case .length:
            return ["Degrees", "Arc Minutes", "Arc Seconds", "Radians", "Gradians", "Revolutions"]
        case .mass:
            return ["Degrees", "Arc Minutes", "Arc Seconds", "Radians", "Gradians", "Revolutions"]
        case .momentOfForce:
            return ["Degrees", "Arc Minutes", "Arc Seconds", "Radians", "Gradians", "Revolutions"]
        case .momentOfInertia:
            return ["Degrees", "Arc Minutes", "Arc Seconds", "Radians", "Gradians", "Revolutions"]
        case .numbers:
            return ["Degrees", "Arc Minutes", "Arc Seconds", "Radians", "Gradians", "Revolutions"]
        case .power:
            return ["Degrees", "Arc Minutes", "Arc Seconds", "Radians", "Gradians", "Revolutions"]
        case .pressure:
            return ["Degrees", "Arc Minutes", "Arc Seconds", "Radians", "Gradians", "Revolutions"]
        case .speed:
            return ["Degrees", "Arc Minutes", "Arc Seconds", "Radians", "Gradians", "Revolutions"]
        case .spesificVolume:
            return ["Degrees", "Arc Minutes", "Arc Seconds", "Radians", "Gradians", "Revolutions"]
        case .temperature:
            return ["Degrees", "Arc Minutes", "Arc Seconds", "Radians", "Gradians", "Revolutions"]
        case .torque:
            return ["Degrees", "Arc Minutes", "Arc Seconds", "Radians", "Gradians", "Revolutions"]
        case .velocityAngular:
            return ["Degrees", "Arc Minutes", "Arc Seconds", "Radians", "Gradians", "Revolutions"]
        case .volume:
            return ["Degrees", "Arc Minutes", "Arc Seconds", "Radians", "Gradians", "Revolutions"]
        case .volumeDry:
            return ["Degrees", "Arc Minutes", "Arc Seconds", "Radians", "Gradians", "Revolutions"]
        }
    }
}
