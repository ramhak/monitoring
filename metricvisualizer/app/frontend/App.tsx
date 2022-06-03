import React, { useState } from "react";
import { Outlet } from "react-router-dom";
import Menu from "./shared/Menu";

function App() {
  return (
    <div className="bg-s-base3 h-screen">
      <Menu />
      <Outlet />
    </div>
  );
}

export default App;
