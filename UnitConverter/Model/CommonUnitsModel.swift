//
//  UnitModel.swift
//  UnitConverter
//
//  Created by Burak Albayrak on 31.08.2024.
//

import Foundation

enum CommonUnitsCategory: String, CaseIterable, UnitCategory {
    case length = "Length"
    case mass = "Weight and Mass"
    case volume = "Volume"
    case temperature = "Temperature"
    case area = "Area"
    case pressure = "Pressure"
    case angle = "Angle"
    case speed = "Speed"
    case duration = "Duration"
    
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
        }
    }
    
    var availableUnits: [Dimension] {
        switch self {
        case .area:
            return [
                // SI Units: Ordered from largest to smallest
                UnitArea.squareMegameters,
                UnitArea.squareKilometers,
                UnitArea.squareMeters,
                UnitArea.squareCentimeters,
                UnitArea.squareMillimeters,
                UnitArea.squareMicrometers,
                UnitArea.squareNanometers,
                // Imperial and Other Common Area Units
                UnitArea.squareMiles,
                UnitArea.acres,
                UnitArea.squareYards,
                UnitArea.squareFeet,
                UnitArea.squareInches,
                // Metric Units (Non-SI)
                UnitArea.hectares,
                UnitArea.ares,
            ]
        case .length:
            return [
                // SI Units: Ordered from largest to smallest
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
                // Imperial and Other Common Units
                UnitLength.inches,
                UnitLength.feet,
                UnitLength.yards,
                UnitLength.miles,
                UnitLength.nauticalMiles,
                UnitLength.furlongs,
                UnitLength.fathoms,
                UnitLength.scandinavianMiles,
                // Astronomical and Other Special Units
                UnitLength.lightyears,
                UnitLength.astronomicalUnits,
                UnitLength.parsecs,
            ]
        case .pressure:
            return [
                // SI Units: Ordered from largest to smallest
                UnitPressure.gigapascals,
                UnitPressure.megapascals,
                UnitPressure.kilopascals,
                UnitPressure.hectopascals,
                UnitPressure.newtonsPerMetersSquared,
                UnitPressure.bars,
                UnitPressure.millibars,
                // Other Common Pressure Units
                UnitPressure.poundsForcePerSquareInch,
                UnitPressure.inchesOfMercury,
                UnitPressure.millimetersOfMercury
            ]
        case .temperature:
            return [
                UnitTemperature.kelvin,
                UnitTemperature.celsius,
                UnitTemperature.fahrenheit,
            ]
        case .volume:
            return [
                // SI Units: Ordered from largest to smallest
                UnitVolume.megaliters,
                UnitVolume.kiloliters,
                UnitVolume.liters,
                UnitVolume.deciliters,
                UnitVolume.centiliters,
                UnitVolume.milliliters,
                // Cubic Units: Ordered from largest to smallest
                UnitVolume.cubicKilometers,
                UnitVolume.cubicMeters,
                UnitVolume.cubicDecimeters,
                UnitVolume.cubicCentimeters,
                UnitVolume.cubicMillimeters,
                // Imperial and Other Common Volume Units
                UnitVolume.acreFeet,
                UnitVolume.bushels,
                UnitVolume.gallons,
                UnitVolume.quarts,
                UnitVolume.pints,
                UnitVolume.cups,
                UnitVolume.fluidOunces,
                UnitVolume.tablespoons,
                UnitVolume.teaspoons,
                // Cubic Imperial Units: Ordered from largest to smallest
                UnitVolume.cubicMiles,
                UnitVolume.cubicYards,
                UnitVolume.cubicFeet,
                UnitVolume.cubicInches,
                // Imperial Units: Ordered from largest to smallest
                UnitVolume.imperialGallons,
                UnitVolume.imperialQuarts,
                UnitVolume.imperialPints,
                UnitVolume.imperialFluidOunces,
                UnitVolume.imperialTablespoons,
                UnitVolume.imperialTeaspoons,
                // Metric Units (Non-SI)
                UnitVolume.metricCups
            ]
        case .mass:
            return [
                // SI Units
                UnitMass.kilograms,
                UnitMass.grams,
                UnitMass.decigrams,
                UnitMass.centigrams,
                UnitMass.milligrams,
                UnitMass.micrograms,
                UnitMass.nanograms,
                UnitMass.picograms,
                // Metric Ton
                UnitMass.metricTons,
                // Imperial Units
                UnitMass.shortTons,
                UnitMass.stones,
                UnitMass.pounds,
                UnitMass.ounces,
                // Other Units
                UnitMass.carats,
                UnitMass.ouncesTroy,
                UnitMass.slugs,
            ]
        case .angle:
            return [
                // Basic Units
                UnitAngle.degrees,
                UnitAngle.arcMinutes,
                UnitAngle.arcSeconds,
                // Metric Units
                UnitAngle.radians,
                UnitAngle.gradians,
                // Special Unit
                UnitAngle.revolutions
            ]
        case .speed:
            return [
                // SI Unit
                UnitSpeed.metersPerSecond,
                // Metric Unit
                UnitSpeed.kilometersPerHour,
                // Imperial Unit
                UnitSpeed.milesPerHour,
                // Nautical Unit
                UnitSpeed.knots,
            ]
        case .duration:
            return [
                UnitDuration.hours,
                UnitDuration.minutes,
                UnitDuration.seconds,
                UnitDuration.milliseconds,
                UnitDuration.microseconds,
                UnitDuration.nanoseconds,
                UnitDuration.picoseconds,
            ]
        }
    }
    
    var availableUnitNames: [String] {
        switch self {
        case .angle:
            return ["Degrees", "Arc Minutes", "Arc Seconds", "Radians", "Gradians", "Revolutions"]
        case .area:
            return ["Square Megameters", "Square Kilometers", "Square Meters", "Square Centimeters", "Square Millimeters", "Square Micrometers", "Square Nanometers", "Square Miles", "Acres", "Square Yards", "Square Feet", "Square Inches", "Hectares", "Ares",]
        case .duration:
            return ["Hours", "Minutes", "Seconds", "Milliseconds", "Microseconds", "Nanoseconds", "Picoseconds"]
        case .length:
            return ["Megameters", "Kilometers", "Hectometers", "Decameters", "Meters", "Decimeters", "Centimeters", "Millimeters", "Micrometers", "Nanometers", "Picometers", "Inches", "Feet", "Yards", "Miles", "Scandinavian Miles", "Furlong", "Lightyears", "Nautical Miles", "Fathoms", "Astronomical Units", "Parsecs"]
        case .mass:
            return ["Kilograms", "Grams", "Decigrams", "Centigrams", "Milligrams", "Micrograms", "Nanograms", "Picograms", "Metric Tons", "Short Tons", "Stones", "Pounds", "Ounces", "Carats", "Ounces Troy", "Slugs"]
        case .pressure:
            return ["Gigapascals", "Megapascals", "Kilopascals", "Hectopascals", "Newtons Per Meter Squared", "Bars", "Millibars", "Pounds Force Per Square Inch", "Inches Of Mercury", "Millimeters Of Mercury"]
        case .speed:
            return ["Meters Per Second", "Kilometers Per Hour", "Miles Per Hour", "Knots"]
        case .temperature:
            return ["Kelvin", "Celsius", "Fahrenheit"]
        case .volume:
            return ["Megaliters", "Kiloliters", "Liters", "Deciliters", "Centiliters", "Milliliters", "Cubic Kilometers", "Cubic Meters", "Cubic Decimeters", "Cubic Centimeters", "Cubic Millimeters", "Acre Feet", "Bushels", "Gallons", "Quarts", "Pints", "Cups", "Fluid Ounces", "Tablespoons", "Teaspoons", "Cubic Miles", "Cubic Yards", "Cubic Feet", "Cubic Inches", "Imperial Gallons", "Imperial Quarts", "Imperial Pints", "Imperial Fluid Ounces", "Imperial Tablespoons", "Imperial Teaspoons", "Metric Cups"]
        }
    }
}
