//
//  FontProvider.swift
//  Nitrozen-SwiftUI
//
//  Created by Hitendra Solanki on 15/03/23.
//

import SwiftUI

public class FontProvider {
	
	public enum ContextTag {
		case heading, subheading, body, label
	}
	
	public enum Variant: Hashable {
		case xxs, xs, s, m, l, xl, xxl
	}
	
	public enum Weight: Hashable {
		case ultrathin, thin, light, regular, medium, semibold, bold, heavy, black
	}
	
	public struct ContextVariantProvider: Hashable {
		var context: ContextTag
		var variant: Variant
	}
	
	public typealias SizeMapper = [ContextVariantProvider : CGFloat]
	var sizeMapper: SizeMapper
	
	public struct FileNameProvider {
		public var ultrathin: String
		public var thin: String
		public var light: String
		public var regular: String
		public var medium: String
		public var semibold: String
		public var bold: String
		public var heavy: String
		public var black: String
	}
	
	//MARK: public properties
	public var fileNames: FileNameProvider
	
	//MARK: Init
	init(
		fileNames: FileNameProvider,
		sizeMapper: [ContextVariantProvider : CGFloat]
	) {
		self.fileNames = fileNames
		self.sizeMapper = sizeMapper
	}
}

public extension FontProvider {
	//MARK: Public Shared
	static var shared: FontProvider = {
		.init(
			fileNames: .init(ultrathin: "", thin: "", light: "", regular: "", medium: "", semibold: "", bold: "", heavy: "", black: ""),
			sizeMapper: [:]
		)
	}()
}


//MARK: Property updaters
public extension FontProvider {
	@discardableResult
	func fileNames(_ fileNames: FileNameProvider) -> Self { self.fileNames = fileNames; return self }
	
	@discardableResult
	func sizeMapperReplacingOld(_ sizeMapper: SizeMapper) -> Self { self.sizeMapper = sizeMapper; return self }
	
	@discardableResult
	func sizeMapperUpdatingOld(_ sizeMapper: SizeMapper) -> Self {
		sizeMapper.forEach { key, value in
			self.sizeMapper[key] = value //updating self sizeMapper
		}
		return self
	}
}


//MARK: Copy Support
public extension FontProvider {
	var copy: FontProvider {
		FontProvider(fileNames: self.fileNames, sizeMapper: self.sizeMapper)
	}
}
