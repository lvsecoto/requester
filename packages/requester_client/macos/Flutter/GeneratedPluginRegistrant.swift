//
//  Generated file. Do not edit.
//

import FlutterMacOS
import Foundation

import network_info_plus
import nsd_macos
import package_info_plus
import path_provider_foundation

func RegisterGeneratedPlugins(registry: FlutterPluginRegistry) {
  NetworkInfoPlusPlugin.register(with: registry.registrar(forPlugin: "NetworkInfoPlusPlugin"))
  NsdMacosPlugin.register(with: registry.registrar(forPlugin: "NsdMacosPlugin"))
  FPPPackageInfoPlusPlugin.register(with: registry.registrar(forPlugin: "FPPPackageInfoPlusPlugin"))
  PathProviderPlugin.register(with: registry.registrar(forPlugin: "PathProviderPlugin"))
}
