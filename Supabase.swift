//
//  Supabase.swift
//  LearnTerms
//
//  Created by Justin Dang on 2/7/25.
//

import Supabase
import Foundation

/// Create a single supabase client for interacting with your database
let supabase = SupabaseClient(supabaseURL: URL(string: "https://mthbwrchcrufqasbmtcr.supabase.co")!, supabaseKey: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im10aGJ3cmNoY3J1ZnFhc2JtdGNyIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzU2MDIyMzUsImV4cCI6MjA1MTE3ODIzNX0.1z5-662JshKfp71aLDgJv-b8hpHugUVsXNJWWBY5wAo")
